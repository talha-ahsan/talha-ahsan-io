FROM crystallang/crystal:latest 
#copy directory, should move this into a work dir at some point in the future though 
COPY . . 
RUN shard install 
CMD crystal run src/talha-ahsan-io.cr