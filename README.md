# install-consul  
test: make test-unit  
docker run --net=host test-consul consul agent -ui -dev  
curl http://localhost:8500  

install: vi install/var  
cd install && bash install.sh
