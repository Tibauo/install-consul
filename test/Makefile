createcontainer:
	@echo "Create Container"
	docker build . -t test-consul

test: createcontainer 
	@echo "Execute test"
	./test.sh
