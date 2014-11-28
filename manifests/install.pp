# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class jenkins_job_builder::install
#
# This class is meant to be called from jenkins_job_builder
# It installs the pip package and all required dependencies
#
class jenkins_job_builder::install(
  $version             = $jenkins_job_builder::version,
  $manage_dependencies = true,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  if $manage_dependencies {
    ensure_resource('package', $jenkins_job_builder::params::python_packages, { 'ensure' => 'present' })
    ensure_resource('package', 'pyyaml', { 'ensure' => 'present', 'provider' => 'pip', 'require' => 'Package[python]'})
  }

  package { 'jenkins-job-builder':
    ensure   => $version,
    provider => 'pip'
  }
}
