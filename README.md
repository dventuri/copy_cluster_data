# copy_cluster_data
Bash shell script to copy MFSim simulation data from remote cluster to local

* To allow execution of the script:
~~~shell
chmod a+x ./copy_cluster_data.sh
~~~

* Use command as:
~~~shell
./copy_cluster_data.sh [case] [time-step number]
~~~
or
~~~shell
./copy_cluster_data.sh [case] last
~~~
where "_last_" looks for last time-step
