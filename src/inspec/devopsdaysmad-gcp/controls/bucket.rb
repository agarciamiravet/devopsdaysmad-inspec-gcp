title 'check bucket properties'

gcp_bucket_name = input('gcp_bucket_name')

control 'bucket-check-basic-properties' do
impact 1.0
title 'Check basic properties like bucket exists and has correct name'
    describe google_storage_bucket(name: gcp_bucket_name) do
        it { should exist }
        its('name') { should eq gcp_bucket_name }
    end
end

control 'bucket-check-iam-policies' do
impact 1.0
title 'Check iam policies from bucket'
    google_storage_bucket_iam_bindings(bucket: gcp_bucket_name).iam_binding_roles.each do |role|
    describe google_storage_bucket_iam_binding(bucket: gcp_bucket_name, role: role)  do
        its('members') { should_not include 'allUsers' }
        its('members') { should_not include 'allAuthenticatedUsers' }
        end
    end
end