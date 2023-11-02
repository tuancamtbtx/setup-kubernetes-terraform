-include .env

tf-apply:
	terraform apply \
		-var="location=$(LOCATION)" \
		-var="project_id=$(PROJECT_ID)" \
		-var="service_account_email=$(SERVICE_ACCOUNT_EMAIL)" \
