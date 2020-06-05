## 类型

| 类型   | -        | bit 长度 | 字节长度 |
| ------ | -------- | -------- | -------- |
| baty   | 字节     | 8        | 1 字节   |
| short  | 双字     | 16       | 2 字节   |
| int    | 整型     | 32       | 4 字节   |
| long   | 长整型   | 64       | 8 字节   |
| float  | 单精实数 | 32       | 4 字节   |
| double | 双精实数 | 64       | 8 字节   |

## 类型转换

- 每个数字类型支持如下的转换

```kotlin
// 显式转换
toByte(): Byte
toShort(): Short
toInt(): Int
toLong(): Long
toFloat(): Float
toDouble(): Double
toChar(): Char

// 隐式转换
val l = 1L + 3      // Long + Int => Long
```

## 运算符

位运算

> 这是完整的位运算列表（只用于 Int 和 Long）

| 类型       | 字面常量                 | 备注   |
| ---------- | ------------------------ | ------ |
| shl(bits)  | 有符号左移 (Java 的 <<)  | <<     |
| shr(bits)  | 有符号右移 (Java 的 >>)  | >>     |
| ushr(bits) | 无符号右移 (Java 的 >>>) | >>>    |
| and(bits)  | 位与                     | &      |
| or(bits)   | 位或                     | \|     |
| xor(bits)  | 位异或                   |        |
| inv()      | 位非                     | 位取反 |

例子

```kotlin
val x = (1 shl 2) and 0x000FF000
```

## 字面常量

> 不支持八进制

| 类型   | 字面常量        | 备注     |
| ------ | --------------- | -------- |
| baty   | 123             |          |
| short  | 0b00001011      | 二进制   |
| int    | 0x0F            | 十六进制 |
| long   | 123L            |          |
| float  | 123.5f、10.5F   |          |
| double | 123.5、123.5e10 |          |

- ### 可用下划线间隔

```kotlin
val oneMillion = 1_000_000
val creditCardNumber = 1234_5678_9012_3456L
val socialSecurityNumber = 999_99_9999L
val hexBytes = 0xFF_EC_DE_5E
val bytes = 0b11010010_01101001_10010100_10010010

```


- 注解
  
```kotlin
// 表示此方法在将来特定版本中会删除 提示改用 this.reply(message) 方法 
@Deprecated("use reply instead", ReplaceWith("this.reply(message)"))
// 这个注解的主要用途就是告诉编译器生成的Java类或者方法的名称
@JvmName("reply3")


```
