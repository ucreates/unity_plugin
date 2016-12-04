#!/usr/bin ruby
require 'xcodeproj'
projectPath = ARGV[0]
frameworkPath = ARGV[1]
apiKey = ARGV[2]
buildSecret = ARGV[3]
project = Xcodeproj::Project.open(projectPath)
target = project.targets[0]
phase = project.new(Xcodeproj::Project::Object::PBXShellScriptBuildPhase)
phase.name = "Run Script for Fabric by Unity Twitter Plugin."
phase.shell_script = frameworkPath + " " + apiKey + " " + buildSecret
target.build_phases.unshift(phase)
project.save()
