# Download the installer
# @since 0.1.0
remote_file 'amazon-ssm-agent' do
  path node['ssm_agent']['package']['path']
  source node['ssm_agent']['package']['url']
  checksum node['ssm_agent']['package']['checksum']
  mode 0644
end

# Install the pakage
# @since 0.1.0
package 'amazon-ssm-agent' do
  source node['ssm_agent']['package']['path']
  provider value_for_platform_family(
    'rhel' => Chef::Provider::Package::Yum,
    'debian' => Chef::Provider::Package::Dpkg
  )
end

# Ensure service state
# @since 0.1.0
service node['ssm_agent']['service']['name'] do
  provider value_for_platform(
    'amazon' => Chef::Provider::Service::Upstart
  )
  action node['ssm_agent']['service']['actions']
end
