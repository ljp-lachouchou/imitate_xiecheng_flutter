


allprojects {
    repositories {

//        mavenCentral()
        maven {
            isAllowInsecureProtocol = true
            url = uri("https://maven.aliyun.com/nexus/content/groups/public/")
        }
        maven {
            isAllowInsecureProtocol = true
            url = uri("https://maven.aliyun.com/nexus/content/repositories/jcenter")
        }
        maven {
            isAllowInsecureProtocol = true
            url = uri("https://maven.aliyun.com/nexus/content/repositories/google")
        }
        maven {
            isAllowInsecureProtocol = true
            url = uri("https://maven.aliyun.com/nexus/content/repositories/gradle-plugin")
        }
        google()
        mavenCentral()
    }
}
buildscript {
    repositories {
        maven {
            isAllowInsecureProtocol = true
            url =  uri("https://maven.aliyun.com/repository/google") }
        maven {
            isAllowInsecureProtocol = true
            url = uri("https://maven.aliyun.com/repository/jcenter") }
        maven {
            isAllowInsecureProtocol = true
            url = uri("https://maven.aliyun.com/nexus/content/groups/public")
        }
        google()
        mavenCentral()
    }
}
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
