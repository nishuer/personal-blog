---
title: JavaScript Tips
date: 2018-01-01 13:47:30
tags:
---

---
## 获取数组的最后一个元素

``` javascript
// 获取数组的最后一个元素
let array = [ 1, 2, 3, 4, 5, 6 ]

console.log(array.slice(-1)) // [6]
```

---
## 显式的块

``` javascript
if (foo) {
    { // <-- 显式的块
        let bar = foo * 2;
        bar = something( bar ); console.log( bar );
    } 
}

function process(data) {
    // 在这里做点有趣的事情
}

// 在这个块中定义的内容可以销毁了! 
{
    let someReallyBigData = { .. }; 
    process( someReallyBigData );
}

var btn = document.getElementById("my_button");

btn.addEventListener( "click", function click(evt){
    console.log("button clicked");
}, /*capturingPhase=*/false );
```

---
## 通用验证函数

``` javascript
// 对象验证规则
const schema = {
    first: {
        required: true
    },
    last: {
        required: true
    }
}

// 通用验证函数
const validate = (schema, values) => {

    for (field in schema) {

        if (schema[field].required) {

            if (!values[field]) {

                return false;
            }
        }
    }

    return true;
}

console.log(validate(schema, {first:'Bruce'})); // false
console.log(validate(schema, {first:'Bruce', last: 'Laser'})); //true

```