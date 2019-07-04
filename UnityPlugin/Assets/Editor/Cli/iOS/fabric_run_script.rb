#!/usr/bin ruby
require 'xcodeproj'
projectPath = ARGV[0]
frameworkPath = ARGV[1]
apiKey = ARGV[2]
buildSecret = ARGV[3]
project = Xcodeproj::Project.open(projectPath)
target = project.targets[0]
for phase in target.build_phases do
  next unless phase.respond_to?(:name)
  if phase.name.to_s.downcase.include?('fabric')
    target.build_phases.delete(phase)
  end
end
phase = project.new(Xcodeproj::Project::Object::PBXShellScriptBuildPhase)
phase.name = 'Run Script for Fabric by Unity Twitter Plugin.'
phase.shell_script = frameworkPath + ' ' + apiKey + ' ' + buildSecret
phase.run_only_for_deployment_postprocessing = '1'
target.build_phases.unshift(phase)
project.save
