#!/usr/bin/env ruby
require_relative './bundle/bundler/setup'

require 'xcodeproj'

project = Xcodeproj::Project.new(ARGV[0])
project.initialize_from_file

rollout_group = project.objects.find { |o| o.isa == "PBXGroup" && (o.path == "Rollout" || o.name == "Rollout") }
files_references = rollout_group ? rollout_group.children.select{|c| c.is_a? Xcodeproj::Project::PBXFileReference} : []
title = "Rollout Code analyzer"

project.targets.each do |target|
  files_references.each do |file_reference|
    target.frameworks_build_phase.remove_file_reference file_reference

    target.source_build_phase.remove_file_reference file_reference

    target.build_configurations.each do |build_configuration|
      framework_search_path = build_configuration.build_settings["FRAMEWORK_SEARCH_PATHS"]
      if ! framework_search_path.nil?
        framework_search_path = [framework_search_path] if framework_search_path.is_a? String
        build_configuration.build_settings["FRAMEWORK_SEARCH_PATHS"] = framework_search_path.select { |path|
          /Rollout-ios-SDK/.match(path).nil?
        }
      end
    end
  end

  if target.respond_to?("product_type") and target.product_type == "com.apple.product-type.application"
    source_build_phase = target.source_build_phase
    build_phases = target.build_phases

    existing_build_phase = build_phases.find { |b| b.respond_to?(:name) and b.name == title} 
    build_phases.delete(existing_build_phase) unless existing_build_phase.nil?
  end
end
rollout_group.remove_from_project unless rollout_group.nil?
project.save()
