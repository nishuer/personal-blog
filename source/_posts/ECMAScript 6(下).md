---
title: ECMAScript 6(下)
date: 2016-10-27 11:59:53
tags: ES6, ES2015
---

- 增强的对象字面量
- 箭头函数
- Promise
- Class
- Module

---

### 增强的对象字面量
定义属性简写，允许只写属性名，不写属性值

``` javascript
// es6

function fn(x, y) {
  return {x, y};
}

// es5

function fn(x, y) {
  return {x: x, y: y};
}
```

定义方法简写

``` javascript
// es6

var person = {
    getName() {
        console.log('name');
    },
    getAge() {
        console.log('age');
    }
};

// es5
var person = {
    getName: function() {
        console.log('name');
    },
    getAge: function() {
        console.log('age');
    }
};
```

允许在对象字面量里面定义原型

``` javascript
var person = {
    getName: function() {
        console.log('name');
    },
    getAge: function() {
        console.log('age');
    }
};

var worker = {
    __proto__: person, //相当于继承person
    company: 'supernano'
};
```

### 箭头函数

#### 一、
箭头函数就是个简写形式的 **函数表达式**，箭头函数总是匿名的。

``` javascript
// es6

(...nameArgs) => nameArgs.join(' ');

// es5

function (firstName, lastName) {
    return firstName + ' ' +lastName;
}
```
箭头函数默认返回单个语句的结果。如果超过了一行，将需要明确使用 `return`。

#### 二、
箭头函数拥有词法作用域的this值（即不会新产生自己作用域下的this, arguments, super 和 new.target 等对象）

``` javascript
// error

function Person() {
    this.age = 0;

    setInterval(function () {
        this.age++; 
    }, 1000);
}

var p = new Person();

// es5

function Person() {
    var self = this;
    self.age = 0;

    setInterval(function () {
        self.age++; 
    }, 1000);
}

var p = new Person();

// or

function Person() {
    this.age = 0;

    setInterval(function () {
        this.age++; 
    }.bind(this), 1000);
}

var p = new Person();

// es6

function Person() {
    this.age = 0;

    setInterval(() => {
        this.age++; 
    }, 1000);
}

var p = new Person();

```

### Promise
Promise是JavaScript异步操作解决方案，允许将回调函数的嵌套，改成链式调用。

``` javascript
// 传统写法

step1(function (value1) {
  step2(value1, function(value2) {
    step3(value2, function(value3) {
      step4(value3, function(value4) {
        // ...
      });
    });
  });
});

// Promises的写法

(new Promise(step1))
  .then(step2)
  .then(step3)
  .then(step4);

```

Generator 函数

``` javascript
function *asyncJob() {
  var f = yield readFile(fileA);
  console.log(f);
}
```

async/await

``` javascript
var asyncReadFile = async function (){
  var f1 = await readFile('/etc/fstab');
  var f2 = await readFile('/etc/shells');
  console.log(f1.toString());
  console.log(f2.toString());
};
```

### Class

``` javascript
// es5

var Shape = function (id, x, y) {
    this.id = id;
    this.move(x, y);
};

Shape.prototype.move = function (x, y) {
    this.x = x;
    this.y = y;
};

// es6

class Shape {
    constructor (id, x, y) {
        this.id = id;
        this.move(x, y);
    }
    move (x, y) {
        this.x = x;
        this.y = y;
    }
}
```
继承
``` javascript
// es6

class Rectangle extends Shape {
    constructor (id, x, y, width, height) {
        super(id, x, y);
        this.width  = width;
        this.height = height;
    }
}

// es5
var Rectangle = function (id, x, y, width, height) {
    Shape.call(this, id, x, y);
    this.width  = width;
    this.height = height;
};
Rectangle.prototype = Object.create(Shape.prototype);
Rectangle.prototype.constructor = Rectangle;
```

### Module

``` javascript
//  lib/math.js
export function sum (x, y) { return x + y };
export var pi = 3.141593;

//  someApp.js
import * as math from "lib/math";
console.log("2π = " + math.sum(math.pi, math.pi));

//  otherApp.js
import { sum, pi } from "lib/math";
console.log("2π = " + sum(pi, pi));
```