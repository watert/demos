

## 内部DSL

jQuery, underscore, Backbone

---

外部DSL，语法糖


- 外部DSL:
	- SQL, HQL, R, XML, Matlab, ... 
	- For **Javascript**: CoffeeScript / TypeScript / LiveScript / Dart
	- 编译生成 Javascript / 直接执行
- Why 外部DSL ? 
	- 语法糖增强可读性 无须括号、`?.` , `?=` 等好处
	- 减轻对相关库的依赖 (尤其是 underscore)
	- 功能性完善：如 
		- Class的写法，对super的支持等
		- 避免命名空间污染

---

生成500随机数：

原生写法

```javascript
var list = (function(){
	var list = [];
	for(i=0;i<500;i++){
		list.push(Math.random()*100);
	}
	return list;
})();
```

Underscore 写法： 

```javascript
var list = _.map(_.range(500),function(){
	 return Math.random()*100 ;
}); 
```

CoffeeScript 写法: 

```coffeescript
list = for i in [1..50] 
	 Math.random()*100
```

---

Class继承

```javascript
var ClassA = function(){ /*initialize*/ };
ClassA.prototype.key1 = "value1";

ClassB = ClassA.prototype
```



## Cheat Sheet
 
### Object


### Array

`[1..5] == [1, 2, 3, 4, 5]`

`[1...5] == [1, 2, 3, 4] # extra dot`

`[3..1] == [3, 2, 1]`

`[1, 2, 3, 4].push(5,6) == [1, 2, 3, 4, 5, 6]`

`[1,3] == i for i in [1..4] when i%2 `

"my string"[0..1] == "my"

### iterate with hasOwnProperty check 

`for own key, value of object`

`copyOfArray = array.slice()`

### Array Reduction
`10 == [1,2,3,4].reduce (x,y) -> x + y`

### Class

```
class Muppet
	constructor: (@age, @hobby) ->
	answerNanny: -> "Everything's cool!"
```

### Nodejs Usages

```coffeescript
fs.readFile 'data.txt', (err, data) ->
	fileText = data
for i in [1..4]
	console.log "Happy Birthday #{if i is 3 then "dear Robert" else "to You"}" 
if "test" in process.argv
	console.log "file testing case"
```