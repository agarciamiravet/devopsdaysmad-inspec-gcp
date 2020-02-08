title 'Check Kubernetes cluster properties'

gcp_project_id = input('gcp_project_id').downcase
gcp_gke_cluster_zone = input('gcp_gke_cluster_zone')
gcp_gke_cluster_name = input('gcp_gke_cluster_name')

control 'gke-check-basicproperties' do
 impact 1.0
 title 'Check if cluster exist and is running'
	 describe google_container_cluster(project: gcp_project_id, zone: gcp_gke_cluster_zone, name: gcp_gke_cluster_name) do
	 	 it { should exist }
	 end
end

control 'gke-check-basic-securitysettings' do
impact 1.0
title 'Check basic security settings'
describe google_container_cluster(project: gcp_project_id, zone: gcp_gke_cluster_zone, name: gcp_gke_cluster_name) do
	 its('untrusted?') { should be false }	 
	end
end

control 'gke-check-logs' do
impact 1.0
title 'Check log settings'
describe google_container_cluster(project: gcp_project_id, zone: gcp_gke_cluster_zone, name: gcp_gke_cluster_name) do
		its('logging_service') { should match /^logging.googleapis.com/ }
	end
end