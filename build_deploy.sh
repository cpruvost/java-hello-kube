#!/bin/bash

export tag=$(docker build -t demo-springboot . | grep 'Successfully built' | tail -c 13)

echo $tag

#docker tag $tag cpruvost/demo-springboot:latest

#docker push cpruvost/demo-springboot

#docker run -it --rm -p 8090:8090 cpruvost/demo-springboot:latest
