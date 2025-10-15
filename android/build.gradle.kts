subprojects {
    repositories {
        google()
        mavenCentral()
    }

    // تعيين مسار build لكل مشروع فرعي
    val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
    project.layout.buildDirectory.value(newBuildDir.dir(project.name))
    
    // التأكد من أن كل مشروع فرعي يعتمد على app
    project.evaluationDependsOn(":app")
}

// مهمة التنظيف (clean)
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
