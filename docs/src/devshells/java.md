# Java

Java 开发环境模板，基于 JDK 17，附带 Maven 和 Gradle 构建工具。

## 使用

```sh
nix flake init -t github:BeauvnTu/Axiom#java
```

## 包含工具

| 包 | 说明 |
|----|------|
| `jdk17` | Java 17 JDK |
| `maven` | Maven 构建工具 |
| `gradle` | Gradle 构建工具 |

## 初始化后

```bash
# 进入开发环境
nix develop

# 验证版本
java -version
mvn -version
gradle -version
```
