#! /bin/bash
# GNU/Linux -->> Debian GNU/Linux 9.6 (stretch)

cd ~

VER=$(lsb_release -a | grep Description | cut -d' ' -f2)

if [[ $VER == *"16.04.4"* ]] || [[ $VER == *"16.04.5"* ]] || [[ $VER == *"GNU/Linux"* ]] ; then

   sed -i 's/arguments "-G Unix Makefiles"/arguments "-GUnix Makefiles"/' devel/adas/samples/android/fr_app/sdk/build.gradle

   SET=$(sed -n "44 p" devel/adas/samples/android/fr_app/sdk/build.gradle | cut -f17- -d' ')

else

   SET=$(find devel/adas/samples/android/fr_app/sdk/build.gradle -type f | xargs grep -n ' arguments "-G Unix Makefiles"' | cut -f17- -d' ')

fi

echo "All Done!!! Run Android Build For Ubuntu ${VER} With Following Settings:${SET}"