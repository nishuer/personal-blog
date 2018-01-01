---
title: ECMAScript 6(上)
date: 2016-09-27 11:59:53
tags: ES6, ES2015
---

- 常量
- 块级作用域
- 解构赋值
- 模板对象
- 默认参数、剩余参数、展开运算符

---

### 一、支持常量
`const` 声明一个常量，仅允许被赋值一次。

``` javascript
// es6

const game = “RPG”;

game = “FPS”; // error


// es5

Object.defineProperty(typeof global === "object" ? global : window, "game", {
    value: "RPG",
    enumerable: true,
    writable: false,
    configurable: false
});
```

### 二、块级作用域
`let` 所声明的变量，只在 `let` 命令所在的代码块内有效。

``` javascript
// es6

let HP = 10;

if (true) {
    let HP = 0;
}

console.log(HP) // 10


// es5

var HP = 10;

(function(){

    if (true) {
        var HP = 0;
    }

}())

console.log(HP) // 10
```

``` javascript
var combo = []; 

for (var i = 0; i < 10; i++) { 
    combo[i] = function() { console.log(i); }; 
}

combo[6](); // 10


// es6

var combo = [];

for (let i = 0; i < 10; i++) {
    combo[i] = function() { console.log(i); };
}

combo[6](); // 6


// es5

var combo = []; 

var fn = function(i) {
    return function() { console.log(i); }
};

for (var i = 0; i < 10; i++) {
    combo[i] = fn(i);
}

combo[6](); // 6
```

不存在变量提升

``` javascript
console.log(player); // undefined
console.log(gender);    // ReferenceError

var player = "soldier";
let gender = "man";
```

全局对象的属性

``` javascript
var boss = "dragon";
window.boss // dragon

let npc = "panda";
window.npc  // undefined
```

### 三、解构赋值

#### 数组解构赋值
``` javascript
// es5

var helmet = 50;
var jacket = 80;
var trouser = 40;


// es6

var [helmet, jacket, trouser] = [50, 80, 40];
```

``` javascript
var [jacket] = [];
var [helmet, jacket] = [50];

jacket // undefined
```

支持默认值设置
``` javascript
var [firstLine, secondLine = 'over'] = ['game'];

console.log(firstLine, secondLine); // game over
```

#### 对象解构赋值

``` javascript
var { blade, sword } = { blade: 1000, sword: 800 };

blade // 1000
sword // 800
```

``` javascript
var { blade: b, sword: s } = { blade: 1000, sword: 800 };

b // 1000
s // 800
```

#### 字符串解构赋值

``` javascript
let [a, b, c, d] = "good";

a // g
b // o
c // o
d // d
```

#### 函数参数解构赋值

``` javascript
function safety([x, y, z]){
  return x + y + z;
}

safety([50, 80, 40]); // 170
```

#### 实际用途

##### 交换变量的值
``` javascript
[helmet, jacket] = [jacket, helmet];
```

##### 定义函数参数
``` javascript
// 参数是一组有次序的值
function safety([x, y, z]) {
     ... 
}
safety([50, 80, 40]);

// 参数是一组无次序的值
function safety({x, y, z}) { 
    ... 
}
safety({z: 40, y: 80, x: 50});
```

##### 载入模块
``` javascript
const { action, numerical } = require("fighting");
```

### 四、模板对象

``` javascript
// es5

var targetText = player + '，你的任务是打败' + boss;


// es6

let targetText = `${player}，你的任务是打败${boss}`;
```

``` javascript
let targetText = `\`${player}\`，你的任务是打败${boss}`;
```

``` javascript
function getBoss() {
    return boss;
}

let targetText = `\`${player}\`，你的任务是打败${getBoss()}`;
```

``` javascript
let targetText = `恭喜您，您的剑强化成功，当前攻击力为${sword * 2}`;
```

``` javascript
//es5

const story = '从前多来国有一个很漂亮的女孩，'
        + '她和母亲在村庄过着幸福快乐的日子，'
        + '可是有一天，东边的山贼来到村庄掠夺村民的粮食，还放火烧了农庄，'
        + '山贼看见了女孩的美貌起了歹念，想侵犯这女孩的身体，'
        + '就在这时一个年轻男孩骑着白色战马拿着利剑朝山贼们冲来，'
        + '铁蹄声刮破了夜晚的宁静，刀光剑影中山贼们落荒而逃。';


// es6

const story = `从前多来国有一个很漂亮的女孩，
        她和母亲在村庄过着幸福快乐的日子，
        可是有一天，东边的山贼来到村庄掠夺村民的粮食，还放火烧了农庄，
        山贼看见了女孩的美貌起了歹念，想侵犯这女孩的身体，
        就在这时一个年轻男孩骑着白色战马拿着利剑朝山贼们冲来，
        铁蹄声刮破了夜晚的宁静，刀光剑影中山贼们落荒而逃。
        `;
```

### 五、默认参数、剩余参数、展开运算符

默认参数

``` javascript
// es5

function countDamage (normalAttack, criticalAttack, magicAttack) {
    var attack = magicAttack || 800;
    return normalAttack + criticalAttack + attack;
}

countDamage(normalAttack, criticalAttack);


// es6

function countDamage (normalAttack, criticalAttack, magicAttack ＝ 800) {
    return normalAttack + criticalAttack + magicAttack;
}

countDamage(normalAttack, criticalAttack);
```

剩余参数

``` javascript
// es6

function countDamage (normalAttack, ...otherAttack) {
    return normalAttack + otherAttack[0] + otherAttack[1];
}

countDamage(normalAttack, criticalAttack, magicAttack);


// es5

function countDamage () {
    var attack = Array.prototype.slice.call(arguments, countDamage.lenght);

    return attack.reduce(function(previousValue, currentValue, index, array){
        return previousValue + currentValue;
    });
}

countDamage(normalAttack, criticalAttack, magicAttack);
```

展开运算符

``` javascript
// es6

function countDamage (normalAttack, criticalAttack, magicAttack) {
    ...
}

var args = [1000, 2000, 800];

countDamage(...args);


// es5

function countDamage (normalAttack, criticalAttack, magicAttack) {
    ...
}

var args = [1000, 2000, 800];

countDamage.apply(null, args);
```