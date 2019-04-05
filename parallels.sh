#!/bin/bash
if [ $# -lt 1 ]; then
   echo "Faltou utilizar pelo menos um argumento!"
   exit 1
fi

#global variables


# inputs
# -p [PLATFORM] -n [node number/ test number] -t [tags] -g group_by scenarios | steps | features -s Skin
while getopts "t:g:n:p:s:a:b:r:f:" OPTION
do
   case $OPTION in
      t) TAGS="--tags $OPTARG"
         OTAG="-o"   
         ;;
         # scenarios | steps | features
      g) GROUP_BY="-p --group-by $OPTARG"
         ;;
      n) NODES="-n $OPTARG"
         NODESN=$OPTARG
         ;;
      p) PLATFORM=$OPTARG
         ;;
      s) SKIN=$OPTARG
         ;;
      a) API=$OPTARG
         ;;
      b) LOJA=$OPTARG
         ;;
      r) REPOSITORIO=$OPTARG
         ;;
      f) FEATURES=$OPTARG
         ;;
   esac
done
shift $((OPTIND-1))

device=([0]=0, [1]=2, [3]=4, [4]=5, [5]=6, [6]=7 })

# environment
function environments(){
      name=$PLATFORM
      export PLATAFORMAAPI=$PLATFORM$API
      export PLATAFORMA=$PLATFORM$API
      export BANDEIRA=$LOJA
      export BRANCH=$REPOSITORIO
      export PARALELO=true
      export VISUAL=false
      adicional=$NODESN
      if [ "$PLATFORM" == "ios" ]; then
      export PLATAFORMA_EX='android'
      export SISTEMA='ios'
      adicional=$(($NODESN+1))
      else
      export PLATAFORMA_EX='ios'
      export SISTEMA='android'
      fi
      if [ "$API" == "10" ]; then
            api=10-0
      elif [ "$API" == "12" ]; then
            api=12-1
      elif [ "$API" == "19" ]; then
            api='system-images;android-19;google_apis;x86'
            aabi=google_apis/x86
            portemulator="7"
      elif [ "$API" == "26" ]; then
            api='system-images;android-26;google_apis;x86_64'
            aabi=google_apis/x86_64
            portemulator="6"
      else
            echo "Versão de sistema não cadastrada"
      fi
};

# create Android Emulators
# Skin 1: J5API19 WXGA  2: Nexus_5X
function create_android_emulator(){
      if [ "$SKIN" == "1" ]; then
            skin=J5API19
      else
            skin=10
      fi
      $ANDROID_HOME/tools/bin/avdmanager -s --silent create avd --force --name ${names[$i]} --abi $aabi --package $api --device $skin
}

# start Android Emulators
 function start_android_emulator(){
      i2=0
      for device in $(emulator -list-avds | GREP $name)
      do
            port=$(($i2*2))
            emulator -avd $device -port 55$portemulator$port -no-snapshot &
            let i2=$i2+1
      done
 }
 function wait_android_emulator(){
       i5=0
       for device in $(emulator -list-avds | GREP $name)
      do
            port2=$(($i5*2))
            while [ "`adb -s emulator-55$portemulator$port2 shell getprop sys.boot_completed | tr -d '\r' `" != "1" ] ; do sleep 1; done
            let i5=$i5+1
      done
 }

# create iOS Emulators
function create_ios_emulator(){
      if [ "$SKIN" == "1" ]; then
            skin=iPhone-7
      else
            skin=iPhone-SE
      fi
      uuid[$i]=`xcrun simctl create ${names[$i]} com.apple.CoreSimulator.SimDeviceType.$skin com.apple.CoreSimulator.SimRuntime.iOS-$api`
      }

# start iOS Emulators
# function start_ios_emulator(){
#       # xcrun simctl boot ${uuid[$i2]}
# }

# start Appium Server
 function appium_start(){
    appium_stop
    appium &>/dev/null &
}

# stop appium server
function appium_stop(){
    ps aux | grep "bin/appium" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# start functional tests
 function start_cucumber_parallel(){
       if [ "$OTAG" == "-o" ]; then
            parallel_cucumber features/$FEATURES $GROUP_BY $NODES $OTAG "$TAGS"
      else
            parallel_cucumber features/$FEATURES $GROUP_BY $NODES 
      fi
 }

# destroi android emulators
function delete_android_emulator(){
      for DEVICE in `ps -ef |grep -v grep |grep emulator |awk '{print $2}'`; do kill -9 $DEVICE; done
      $ANDROID_HOME/tools/bin/avdmanager delete avd -n ${names[$i1]} &>/dev/null &
}

# destroi ios emulators
function delete_ios_emulator(){
      xcrun simctl shutdown ${uuid[$i1]}
      sleep 20
      xcrun simctl delete ${uuid[$i1]}
}

# generate report
function generate_report(){
      report_builder -s "reports/$PLATFORM$API" -o $PLATFORM$API$LOJA$REPOSITORIO.html
}


environments

i=0
while [ $i -lt $adicional ]; do
      names[$i]=$name$API$i
      if [ "$PLATFORM" == "ios" ]; then
          create_ios_emulator
      else
          create_android_emulator  
      fi
      let i=$i+1
done

if [ "$PLATFORM" == "android" ]; then
      start_android_emulator
fi

mkdir -p reports/"$PLATFORM$API"

appium_start

if [ "$PLATFORM" == "android" ]; then
      wait_android_emulator
fi

sleep 10

start_cucumber_parallel

generate_report

appium_stop

i1=0
while [ $i1 -lt $adicional ]; do
      if [ "$PLATFORM" == "ios" ]; then
          delete_ios_emulator
      else
          delete_android_emulator 
      fi
      let i1=$i1+1
done