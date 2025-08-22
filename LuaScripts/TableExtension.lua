-- Extra table stuff that's good yee
export type CastedValueMethod = (data: any) -> any
export type ValueMethod = string | (itemData: any) -> any | nil

type WeightMethod = (arrayOrDict: ArrayOrDict, key: any) -> number

type ArrayOrDict = { any } | { [any]: any }

local EXTENSION = {}

local function returnPassed(passed: any)
	return passed
end

local RNG = Random.new()

-- Casts the value method to a function that can be called on a table with
function EXTENSION.castValueMethod(valueMethod: ValueMethod): CastedValueMethod
	if type(valueMethod) == "string" then
		return function(data)
			return data[valueMethod]
		end
	elseif valueMethod then
		return function(data)
			return valueMethod(data)
		end
	else
		return returnPassed
	end
end

do
	local seedless = {}
	EXTENSION.SEEDLESS = seedless
	seedless.__index = seedless

	local actuallyRandom = Random.new()

	local function getKey(_, key: any)
		return key
	end
	
	local function getValue(arrayOrDict, key: any)
		return arrayOrDict[key]
	end
	
	local function weightComp(obj1, obj2)
		return obj1.weight < obj2.weight
	end
	
	local function weightedShuffleHelper(arrayOrDict: ArrayOrDict, weightMethod: WeightMethod?, shouldClone: boolean?, rand: Random?): { any }
		weightMethod = weightMethod or getValue
		local sortedWeightObjs = {}
		
		rand = rand or RNG
		
		-- Divide random number by weight (larger weight → smaller key)
		for oldKey, value in pairs(arrayOrDict) do
			table.insert(sortedWeightObjs, {
				weight = rand:NextNumber() ^ (1 / weightMethod(arrayOrDict, oldKey));
				value = value;
			})
		end

		EXTENSION.sort(sortedWeightObjs, weightComp)
		
		-- Converts to array if it's a dictionary, or clones if specified
		local outputTable = #arrayOrDict == 0 and {} or (shouldClone and table.clone(arrayOrDict) or arrayOrDict)
		for i, weightObj in ipairs(sortedWeightObjs) do
			outputTable[i] = weightObj.value
		end
		
		return outputTable
	end

	local function shuffleHelper(arrayOrDict: ArrayOrDict, n: number?, shouldClone: boolean?, rand: Random?): { any }
		assert(arrayOrDict, "Array or dictionary required, but got nil")
		local outputTable = shouldClone and table.clone(arrayOrDict) or arrayOrDict
		local itemCt = #arrayOrDict
		local isArray = itemCt > 0

		local keys: {}?
		if not isArray then
			keys = {}
			for key in arrayOrDict do
				table.insert(keys, key)
			end
			itemCt = #keys
		end

		n = n or itemCt
		assert(n <= itemCt, "n cannot be greater than the number of items in the array.")

		local stopIdx = math.max(itemCt - n, 2)
		local keyFun = isArray and returnPassed or function(key: any)
			return keys[key]
		end

		rand = rand or RNG

		for i = itemCt, stopIdx, -1 do
			local j = rand:NextInteger(1, i)
			outputTable[keyFun(i)], outputTable[keyFun(j)] = arrayOrDict[keyFun(j)], arrayOrDict[keyFun(i)]
		end

		return outputTable
	end

	local function chooseHelper(
		arrayOrDict: ArrayOrDict,
		n: number?,
		allowDupes: boolean?,
		valueFunction: (array: ArrayOrDict, key: any) -> any,
		rand: Random?
	): { any }
		assert(arrayOrDict, "Array or dictionary required, but got nil")
		local arr = {}

		if #arrayOrDict > 0 then
			if n == 1 and n < #arr then
				return valueFunction(arrayOrDict, RNG:NextInteger(1, #arr))
			end

			for key in ipairs(arrayOrDict) do
				table.insert(arr, valueFunction(arrayOrDict, key))
			end
		else
			for key in arrayOrDict do
				table.insert(arr, valueFunction(arrayOrDict, key))
			end
		end

		n = n or 1

		assert(n <= #arr, "n cannot be greater than the number of items in the array.")

		rand = rand or RNG

		if n == 1 then
			return arr[rand:NextInteger(1, #arr)]
		end

		local choices = {}
		if not allowDupes then
			for i = #arr, #arr - n + 1, -1 do
				local j = rand:NextInteger(1, i)
				arr[i], arr[j] = arr[j], arr[i]
				table.insert(choices, arr[i])
			end
		else
			for i = #arr, #arr - n + 1, -1 do
				table.insert(choices, arr[rand:NextInteger(1, i)])
			end
		end

		return choices
	end

	do
		function seedless.shuffle(arrayOrDict: ArrayOrDict, n: number?, shouldClone: boolean?): { any }
			return shuffleHelper(arrayOrDict, n, shouldClone, actuallyRandom)
		end
		
		function seedless.weightedShuffle(arrayOrDict: ArrayOrDict, weightMethod: WeightMethod, shouldClone: boolean?): { any }
			return weightedShuffleHelper(arrayOrDict, weightMethod, shouldClone, actuallyRandom)
		end
		
		function seedless.choose(arrayOrDict: ArrayOrDict, n: number?, allowDupes: boolean?)
			return chooseHelper(arrayOrDict, n, allowDupes, getValue, actuallyRandom)
		end

		function seedless.chooseKey(arrayOrDict: ArrayOrDict, n: number?, allowDupes: boolean?)
			return chooseHelper(arrayOrDict, n, allowDupes, getKey, actuallyRandom)
		end
	end

	-- Shuffles the values in a table in O(n)
	-- If n is specified, only shuffles the last n items
	-- By default, does an in place shuffle but if clone is true, creates a new array
	function EXTENSION.shuffle(arrayOrDict: ArrayOrDict, n: number?, shouldClone: boolean?): { any }
		return shuffleHelper(arrayOrDict, n, shouldClone)
	end
	
	-- Shuffles the values in a table based on their weights (largest will likely be found near the end of the result list)
	-- By default, does an in place shuffle but if clone is true OR a dictionary is passed, creates a new array
	-- The weightMethod is a function that takes in the array and the key, to return the number representing the item weight
	-- Time complexity is based on EXTENSION.sort algorithm
	function EXTENSION.weightedShuffle(arrayOrDict: ArrayOrDict, weightMethod: WeightMethod, shouldClone: boolean?): { any }
		return weightedShuffleHelper(arrayOrDict, weightMethod, shouldClone)
	end
	
	-- Chooses n different random items. Returns an array if n > 1
	function EXTENSION.choose(arrayOrDict: ArrayOrDict, n: number?, allowDupes: boolean?): any | { any }
		return chooseHelper(arrayOrDict, n, allowDupes, getValue)
	end

	-- Chooses n different random keys. Returns an array if n > 1
	function EXTENSION.chooseKey(arrayOrDict: ArrayOrDict, n: number?, allowDupes: boolean?): any | { any }
		return chooseHelper(arrayOrDict, n, allowDupes, getKey)
	end
end

-- Deep copies the given table and returns the copy
function EXTENSION.deepCopy(tbl: {}): {}
	local copy = {}
	for k, v in pairs(tbl) do
		if type(v) == "table" and not v.RunAt then
			v = EXTENSION.deepCopy(v)
		elseif typeof(v) == "Instance" then
			v = v:Clone()
		end
		copy[k] = v
	end
	return copy
end

do -- Table change stuff
	type OppType = "add" | "nullify" | "set"

	local function addNums(n1: number | NumberRange?, n2: number | NumberRange?): number | NumberRange
		n1 = n1 or 0
		n2 = n2 or 0
		if type(n1) == "number" then
			n1, n2 = n2, n1
		end

		if type(n1) == "number" then
			return n1 + n2
		else
			local newMin, newMax = n1.Min, n1.Max
			assert(newMin and newMax, "n1 and n2 must be addable, but got type: " .. typeof(n1))
			if type(n2) == "number" then
				newMin += n2
				newMax += n2
			else
				newMin += n2.Min
				newMax += n2.Max
			end
			return NumberRange.new(newMin, newMax)
		end
	end

	local function changeCopy(tbl, changes)
		local copy = tbl
		if changes then
			copy = {}
			for k, v in pairs(tbl) do
				if type(v) == "table" then
					v = changeCopy(v, changes[k])
				elseif typeof(v) == "Instance" then
					v = v:Clone()
				end
				copy[k] = v
			end
		end

		return copy
	end

	local function createNonChangeCopy(tbl, changes)
		local copy
		if typeof(changes) == "table" then
			copy = {}
			for k, v in pairs(changes) do
				if typeof(v) == "table" and not v.op then
					copy[k] = createNonChangeCopy(tbl[k], v)
				else
					copy[k] = tbl[k]
				end
			end
		end

		return copy
	end

	local function applyChangesHelper(tbl, changes)
		if typeof(changes) == "table" and typeof(tbl) == "table" then
			for k, v in pairs(changes) do
				if typeof(v) == "table" then
					local oppType: OppType? = v.op
					if not oppType and tbl[k] then
						v = applyChangesHelper(tbl[k], v)
					elseif oppType == "add" then
						if typeof(tbl[k]) ~= "table" then
							tbl[k], v.val = v.val, tbl[k]
						end

						if typeof(tbl[k]) ~= "table" then
							v = addNums(tbl[k], v.val)
						else
							local val = typeof(v.val) ~= "table" and v.val
							for k2, v2 in pairs(tbl[k]) do
								tbl[k][k2] = applyChangesHelper(v2, addNums(v2, val or v.val[k2]))
							end
							v = tbl[k]
						end
					elseif oppType == "nullify" then
						v = nil
					elseif oppType == "set" then
						v = v.val
					end
				end
				tbl[k] = v
			end
		else
			return changes
		end

		return tbl
	end

	-- Only deep copies anything that will be changed, and applies the changes in the change table
	function EXTENSION.applyChanges(tbl: {}, changes: {}, ignoreNonChanges: boolean?)
		return applyChangesHelper(
			not ignoreNonChanges and changeCopy(tbl, changes) or createNonChangeCopy(tbl, changes),
			changes
		)
	end

	function EXTENSION.updateTable(tbl: {}, changes: {})
		return applyChangesHelper(tbl, changes)
	end

	local function createOp(oppType: OppType, val: any?)
		return { op = oppType, val = val }
	end

	-- Operator to add something else to this
	function EXTENSION.addOp(toAdd)
		assert(toAdd ~= nil, "Must be adding something")
		return createOp("add", toAdd)
	end

	function EXTENSION.setOp(setTo: any)
		return createOp("set", setTo)
	end

	EXTENSION.NIL = table.freeze(createOp("nullify"))
end

-- Converts the given table to an array
-- If `convertTableKeys` is true, then the keys of the table will be used as the values
function EXTENSION.convertTable(t: { [any]: any }, convertTableKeys: boolean?): { any }
	local arr = {}
	if not convertTableKeys then
		for _, v in pairs(t) do
			table.insert(arr, v)
		end
	else
		for k in pairs(t) do
			table.insert(arr, k)
		end
	end
	return arr
end

-- Converts the given array to a table with the values being the data
function EXTENSION.convertArray(a: { any }, keyMethod: ValueMethod?, valueMethod: ValueMethod?): { [any]: any }
	local castedKeyMethod = EXTENSION.castValueMethod(keyMethod)
	local castedValueMethod = EXTENSION.castValueMethod(valueMethod)
	local t = {}
	for _, value in ipairs(a) do
		t[castedKeyMethod(value)] = castedValueMethod(value)
	end
	return t
end

function EXTENSION.binarySearch(arr, value)
	local low, high = 1, #arr
	while low <= high do
		local mid = math.floor((low + high) / 2)
		if arr[mid] < value then
			low = mid + 1
		elseif arr[mid] > value then
			high = mid - 1
		else
			return mid
		end
	end
	return high -- Returns the idx where the item is at or lower than the value
end

-- Creates a new array with source values not in remove arr
-- If it's a set, it will use the keys from the set, otherwise values
-- Source should be an array
function EXTENSION.filter(source: {}, removeArrOrSet: {})
	local removeSet
	-- Populate the set with elements to remove
	if #removeArrOrSet > 0 then
		removeSet = {}
		for _, value in ipairs(removeArrOrSet) do
			removeSet[value] = true
		end
	else
		removeSet = removeArrOrSet
	end

	local filteredArray = {}
	-- Keep only elements not in removeSet
	for _, value in ipairs(source) do
		if not removeSet[value] then
			table.insert(filteredArray, value)
		end
	end

	return filteredArray
end

do -- Sorting
	local MIN_MERGE = 32

	local function defaultComp(a, b)
		return a < b
	end

	local function getMinRun(n)
		local r = 0
		while n >= MIN_MERGE do
			r = bit32.bor(r, bit32.band(n, 1))
			n = bit32.rshift(n, 1)
		end
		return n + r
	end

	local function binaryInsertionSort(a, left, right, comp)
		for i = left + 1, right do
			local key = a[i]
			local lo = left
			local hi = i - 1
			while lo <= hi do
				local mid = math.floor((lo + hi) / 2)
				if comp(key, a[mid]) then
					hi = mid - 1
				else
					lo = mid + 1
				end
			end
			for j = i - 1, lo, -1 do
				a[j + 1] = a[j]
			end
			a[lo] = key
		end
	end

	local function merge(a, l, m, r, comp)
		local len1 = m - l + 1
		local len2 = r - m
		local left, right = {}, {}
		for i = 1, len1 do
			left[i] = a[l + i - 1]
		end
		for i = 1, len2 do
			right[i] = a[m + i]
		end

		local i, j, k = 1, 1, l
		while i <= len1 and j <= len2 do
			if comp(right[j], left[i]) then
				a[k] = right[j]
				j = j + 1
			else
				a[k] = left[i]
				i = i + 1
			end
			k = k + 1
		end
		while i <= len1 do
			a[k] = left[i]
			i = i + 1
			k = k + 1
		end
		while j <= len2 do
			a[k] = right[j]
			j = j + 1
			k = k + 1
		end
	end

	-- In place Timsort implementation for arrays
	-- Best: O(n) | Worst / Avg: O(n log n)
	-- Accepts optional comparator function (a, b) -> bool
	function EXTENSION.sort(arr: { any }, comp: ((any, any) -> boolean)?)
		comp = comp or defaultComp
		local n = #arr
		if n == 0 then
			return
		end
		local minRun = getMinRun(n)
		for start = 1, n, minRun do
			local end_ = math.min(start + minRun - 1, n)
			binaryInsertionSort(arr, start, end_, comp)
		end

		local size = minRun
		while size < n do
			for left = 1, n, 2 * size do
				local mid = math.min(left + size - 1, n)
				local right = math.min(left + 2 * size - 1, n)
				if mid < right then
					merge(arr, left, mid, right, comp)
				end
			end
			size = size * 2
		end
	end
end

-- Deque
do
	local Deque = {}
	Deque.__index = Deque

	-- Create new deque
	function Deque.new()
		return setmetatable({first = 0, last = -1, data = {}}, Deque)
	end

	-- Push to the front
	function Deque:pushFront(value)
		self.first = self.first - 1
		self.data[self.first] = value
	end

	-- Push to the back
	function Deque:pushBack(value)
		self.last = self.last + 1
		self.data[self.last] = value
	end

	-- Pop from the front
	function Deque:popFront()
		if self:isEmpty() then return nil end
		local value = self.data[self.first]
		self.data[self.first] = nil
		self.first = self.first + 1
		return value
	end

	-- Pop from the back
	function Deque:popBack()
		if self:isEmpty() then return nil end
		local value = self.data[self.last]
		self.data[self.last] = nil
		self.last = self.last - 1
		return value
	end

	-- Peek front
	function Deque:peekFront()
		if self:isEmpty() then return nil end
		return self.data[self.first]
	end

	-- Peek back
	function Deque:peekBack()
		if self:isEmpty() then return nil end
		return self.data[self.last]
	end

	-- Check empty
	function Deque:isEmpty()
		return self.first > self.last
	end

	-- Override default len method
	function Deque:__len()
		return self.last - self.first + 1
	end

	-- Override default iter method
	function Deque:__iter()
		local i = self.first - 1
		return function()
			i = i + 1
			if i <= self.last then
				return self.data[i]
			end
		end
	end

	EXTENSION.Deque = Deque
end

-- Sets the rng for the module. If no value is provided, it will use a new one.
function EXTENSION:SetRng(random: Random)
	RNG = random or Random.new()
end

return EXTENSION
