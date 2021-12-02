#!/usr/bin/env sh


#############comands
dfCmds=(
  "adb"
  "node"
  "npx"
  "yarn"
  "react-native"
)

dfErrorCmds=(
  "set path SDK/platform_tools to environment system"
  "install nodejs"
  "install nodejs"
  "install yarn"
  "npm i -g react-native-cli"
)
#############comands

#############folders
folders=(
  "src/apis"
  "src/assets/fonts"
  "src/databases/queries"
  "src/databases/tables"
  "src/libs"
  "src/locales"
  "src/models"
  "src/repositories"
  "src/views/components"
  "src/views/customs"
  "src/views/details"
  "src/views/items"
  "src/views/pages"
  )
#############folders

#############def
userCmd=()
#############def


helpMe(){
  echo -e "\n \e[38;2;250;50;250mb\e[38;2;0;150;150muild\n\t \e[38;2;250;50;250md\e[38;2;255;255;255mebug\e[38;2;150;150;150m build debug apk without sign keykey\n\t\t\e[38;2;255;200;15m ReactTools b|ReactTools b d\n\t \e[38;2;250;50;250mr\e[38;2;50;255;50melease\e[38;2;150;150;150m build release apk wit sign key\n\t\t\e[38;2;255;200;15m ReactTools b r"

  echo -e "\n \e[38;2;250;50;250mc\e[38;2;0;150;150mheck\n\t \e[38;2;250;50;250mr\e[38;2;255;255;255mequire\e[38;2;150;150;150m check requirements react-native\n\t\t\e[38;2;255;200;15m ReactTools c r"

	echo -e "\n \e[38;2;250;50;250mh\e[38;2;0;150;150melp, -h, --help"

  echo -e "\n \e[38;2;250;50;250mi\e[38;2;0;150;150mnstall\n\t \e[38;2;250;50;250mr\e[38;2;255;255;255meact {NAME_PROJECT}\e[38;2;150;150;150m install react-native project with custom template\n\t\t\e[38;2;255;255;255m-v\e[38;2;150;150;150m=\e[38;2;50;255;50m0.64.2\e[38;2;150;150;150m version react|\e[38;2;255;255;255m-nt\e[38;2;150;150;150m create without custom template\n\t\t\e[38;2;255;200;15m ReactTools i r TestReactTools"

  echo -e "\n \e[38;2;250;50;250mm\e[38;2;0;150;150make\n\t \e[38;2;250;50;250ms\e[38;2;255;255;255mrc\e[38;2;150;150;150m make folders for react-native\n\t\t\e[38;2;255;255;255m-o\e[38;2;150;150;150m path make src\n\t\t\e[38;2;255;200;15m ReactTools m s -o newProject"

  echo -e "\n \e[38;2;250;50;250ms\e[38;2;0;150;150mtart\n\t \e[38;2;250;50;250ma\e[38;2;255;255;255mdb\e[38;2;150;150;150m connect to device \e[38;2;50;255;50mdef=usb\n\t \e[38;2;250;50;250ma\e[38;2;255;255;255mdb:\e[38;2;50;255;50musb\e[38;2;150;150;150m connect to device with usb\n\t \e[38;2;250;50;250ma\e[38;2;255;255;255mdb:wifi {ADDRESS:PORT}\e[38;2;150;150;150m connect to device with wifi\n\t\t\e[38;2;255;200;15m ReactTools s a:wifi 192.168.1.101\n\t \e[38;2;250;50;250ms\e[38;2;50;255;50merver\e[38;2;150;150;150m start server react-native\n\t\t\e[38;2;255;200;15m ReactTools s s| ReactTools s"
}

runCmd(){
  local tmp=("$@")

  case ${tmp[0]} in
    help|h)
      helpMe
    ;;

    make|m)
      makeCommands ${tmp[1]}
    ;;

    check|c)
      checkCommands ${tmp[1]}
    ;;

    install|i)
      tmp=(${tmp[@]:1:3})
      installCommands "${tmp[@]}"
    ;;

    start|s)
      tmp=(${tmp[@]:1:3})
      startCommands "${tmp[@]}"
    ;;
    
    build|b)
      buildCommands ${tmp[1]}
    ;;
    
    *)
      errorCmd
    ;;

  esac 
}

makeCommands(){
  local result

  IFS=':' read -ra result <<< "$1"

  case ${result[0]} in
    src)
  
      mkDirSrcReact

      if [ "$userType" = "full" ]; then
        createFilesReact
      else
        createFilesReact
      fi
    ;;
    *)
      errorCmd
    ;;
  esac

}

checkCommands(){
  case $1 in
    *|require)
      checkDfCmd
    ;;
  esac
}

installCommands(){
  local tmp=("$@")

  case ${tmp[0]} in
    react|r)
      installReactCommands "${tmp[1]}"
    ;;

    *)
      helpMe
    ;;
  esac 
}

startCommands(){
  local tmp=("$@")
  local result
  
  IFS=':' read -ra result <<< "${tmp[0]}"

  case ${result[0]} in
    adb|a)
      
      echoColorCheck 2 "connect ..."

      if [ "${result[1]}" = "wifi" ];then
        adb connect ${tmp[1]}
      else
        adb usb
      fi

      adb reverse tcp:8081 tcp:8081

      echoColorCheck 1 "reverse"

    ;;

    *|server|s)
      npx react-native start
    ;;

  esac

}

buildCommands(){
  case $1 in
    release|r)
      npx react-native run-android --variant=release
    ;;

    *|debug|d)
      npx react-native run-android
    ;;
  esac
}

installReactCommands(){
  local v

  [[ -z "$userVersion" ]] && v="0.64.2" || v=$userVersion

  npx react-native init $1 --version $v

  if [ "$userType" != 0 ]; then

    mkDirSrcReact "./$1"

    createFilesReact $1

  fi

}

errorCmd(){
  echo -e "\e[38;2;150;0;0m error not found Command"
  exit 1
}

mkDirSrcReact(){
  local tmpOutput=$1

  if [ -n "$userOutput" ]; then
    tmpOutput=$userOutput
  else
    [[ -n "$1" ]] && tmpOutput=$1 || tmpOutput="."
  fi

  for i in "${folders[@]}"
  do
    : 
    mkdir -p "$tmpOutput/$i"
    echo $i
  done

  unset tmpOutput
}

createFilesReact(){
  local tmpOutput

  if [ -n "$userOutput" ]; then
    tmpOutput="$userOutput/src"
  else
    [[ -n "$1" ]] && tmpOutput="./$1/src" || tmpOutput="./src"
  fi

  echo -e "const Config = {\n\turlSiteBase: 'http://%SITE%/',\n\turlSite: 'http://%SITE%/backend/public/api/',\n\turlSiteStorage: 'http://%SITE%/backend/public/storage/',\n\tdefaultLanguage: 'fa',\n};\n\n\n/**\n *\n * @param {String} url @example home search\n * @param {Array} path @example url:home={0}&id={1}&exit={0} {\"yes\",1} =>home=yes&id=1&exit=yes\n * @param {'api'|'storage'|'base'} type @example add /api/ to url\n */\n\nexport const getUrl = (url, path, type = 'api') => {\nlet str =(type == 'api'\n? Config.urlSite\n: type == 'base'\n? Config.urlSiteBase\n: Config.urlSiteStorage) + url;\n\n
  if (path != undefined) {
    if (!(path instanceof Array)) path = [path];\n\nlet pos = 0;\nwhile (true) {\nlet indexStart = str.indexOf('{', pos);\nlet indexEnd = str.indexOf('}', indexStart);\nif (indexStart == -1) break;\nif (indexEnd == -1 || indexStart + 4 < indexEnd)
        throw new Error('not found End {}');
      \nlet tmp = str.substr(indexStart + 1, indexEnd - indexStart - 1);\nlet indexPath = parseInt(tmp);\n\nif (indexPath > path.length) throw new Error(\`not found {\${indexPath}}\`);\n\nstr = str.replace(\`{\${tmp}}\`, path[indexPath]);\n\npos = indexEnd;
    }\n}\n\n\treturn str;\n};
  \n\n\nexport default Config;
  " >> "$tmpOutput/Config.js"



  echo -e "\nimport {StyleSheet} from 'react-native';\nexport default GlobalStyle = StyleSheet.create({
  card: {\nbackgroundColor: '#fff',\nborderRadius: 8,\nelevation: 4,\nshadowColor: '#c3c3c3',\nshadowOffset: {\nheight: 5,\nwidth: 0,\n},\nshadowOpacity: 1,\nshadowRadius: 1,\n},\nelevation: {\nbackgroundColor: '#fff',\nelevation: 4,\nshadowColor: '#c3c3c3',\nshadowOffset: {\nheight: 5,\nwidth: 0,\n},\nshadowOpacity: 1,\nshadowRadius: 1,\n},\ncolumn: {\nflexDirection: 'column',\n},\ncolumnSpace: {\nflexDirection: 'column',\njustifyContent: 'space-between',\n},
  dialog: {\nalignContent: 'center',\nalignItems: 'center',\nalignSelf: 'center',\nbackgroundColor: 'rgba(1,1,1,0.3)',\nflex: 1,\nheight: '100%',\njustifyContent: 'center',\nwidth: '100%',\n},\nmargin2: {\nmargin: 2,\n},\nmargin4: {\nmargin: 4,\n},\nmargin8: {\nmargin: 8,\n},\nmargin12: {\nmargin: 12,\n},\nmargin20: {\nmargin: 20,\n},\nmargin40: {\nmargin: 40,\n},\nmargin50: {\nmargin: 50,\n},\nmarginLeftRight4: {\nmarginEnd: 4,\nmarginLeft: 4,\nmarginRight: 4,\nmarginStart: 4,\n},\nmarginLeftRight8: {\nmarginEnd: 8,\nmarginLeft: 8,\nmarginRight: 8,\nmarginStart: 8,\n},\nmarginLeftRight12: {\nmarginEnd: 12,\nmarginLeft: 12,\nmarginRight: 12,\nmarginStart: 12,\n},\nmarginLeftRightBottom20B6: {\nmarginBottom: 6,\nmarginEnd: 20,\nmarginLeft: 20,\nmarginRight: 20,\nmarginStart: 20,\n},\nmarginTop4: {\nmarginTop: 4,\n},\nmarginTop8: {\nmarginTop: 8,\n},\nmarginTop12: {\nmarginTop: 12,\n},\nmarginTop15: {\nmarginTop: 15,\n},\nmarginTop20: {\nmarginTop: 20,\n},\nmarginTop40: {\nmarginTop: 40,\n},\nmarginBottom8: {\nmarginBottom: 8,\n},\nmarginBottom20: {\nmarginBottom: 20,\n},\nmarginBottom40: {\nmarginBottom: 40,\n},\npadding4: {\npadding: 4,\n},\npadding8: {\npadding: 8,\n},\npadding12: {\npadding: 12,\n},\npaddingBottom8: {\npaddingBottom: 8,\n},\npaddingTop8: {\npaddingTop: 8,\n},\npaddingLeftRight4: {\npaddingEnd: 4,\npaddingLeft: 4,\npaddingRight: 4,\npaddingStart: 4,\n},\npaddingLeftRight8: {\npaddingEnd: 8,\npaddingLeft: 8,\npaddingRight: 8,\npaddingStart: 8,\n},\npaddingLeftRight12: {\npaddingEnd: 12,\npaddingLeft: 12,\npaddingRight: 12,\npaddingStart: 12,\n},\nrow: {\nalignItems: 'center',\nflexDirection: 'row',\n},\nrowReverse: {\nalignItems: 'center',\nflexDirection: 'row-reverse',\n},\nrowReverseSpace: {\nalignItems: 'center',\nflexDirection: 'row-reverse',\njustifyContent: 'space-between',\n},\nrowSpace: {\nalignItems: 'center',\nflexDirection: 'row',\njustifyContent: 'space-between',\n},\nrowSpaceAround: {\nalignItems: 'center',\nflexDirection: 'row',\njustifyContent: 'space-around',\n},\ntextLight: {\nfontFamily: 'iransansDn',\ntextAlign: 'right',\n},\ntext: {\nfontFamily: 'iransansDn',\ntextAlign: 'right',\ncolor: '#2e2e2e',\n},\ntextBold: {\nfontFamily: 'IRANSansMobileFaNum-Bold',\nfontSize: 11,\ntextAlign: 'right',\ncolor: '#2e2e2e',\n},\nfontIranSans: {\nfontFamily: 'iransansDn',\n},\nfontIranSansBold: {\nfontFamily: 'IRANSansMobileFaNum-Bold',\n},\nthemeApp: {\nbackgroundColor: '#4D2C91',\n},\nline: {\nwidth: '100%',\nheight: 2,\nbackgroundColor: '#4D2C91',\n},\ncenter: {\nalignContent: 'center',\nalignItems: 'center',\njustifyContent: 'center',\n},\ntextCenter: {\ntextAlign: 'center',\ntextAlignVertical: 'center',\n},\nwarpView: {\nflexWrap: 'wrap',\n},\n});\n\n/**\n * @template T\n * @param { T | StyleSheet.NamedStyles<T>} styles\n * @param {360|480|640|853} size\n *\n * @returns {{size: T | StyleSheet.NamedStyles<T>}}\n */\n\nexport const createStyleSheet = (styles, size = 360) => {\nconst style = {};\n\nstyle[\`\${size}\`] = StyleSheet.create(styles);\n\nreturn style;\n};\nexport const getSizeScreen = () =>\n\trequire('react-native').Dimensions.get('screen');\n" >> "$tmpOutput/GlobalStyles.js"

  unset tmpOutput
}

checkDfCmd(){
  local i=0
  for ((i=0; i<${#dfCmds[@]}; i++)); do
    local cmd=${dfCmds[i]}

    if ! command -v $cmd &> /dev/null
    then
        echoColorCheck 0 $cmd "${dfErrorCmds[i]}"
      else
        echoColorCheck 1 $cmd
    fi
  done

  echo -e "\n"

  if [ ! -d "$JAVA_HOME" ]
  then
        echoColorCheck 0 "JAVA_HOME" "set path JDK 1.8 to environment system"
      else
        echoColorCheck 1 "JAVA_HOME"
  fi

  if [ ! -d "$ANDROID_HOME" ]
  then
        echoColorCheck 0 "ANDROID_HOME" "set path SDK to environment system"
      else
        echoColorCheck 1 "ANDROID_HOME"
  fi
}

echoColorCheck(){
  if [ "$1" == 1 ]; then
      echo -e "\e[38;2;0;150;0m $2 ✔"
  elif [ "$1" == 2 ]; then
      echo -e "\e[38;2;55;225;225m $2 🔃"
  else
      echo -e "\e[38;2;150;0;0m $2 ❌ \e[38;2;255;200;15m =>\t$3"
  fi
}
    
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      helpMe ${userCmd[0]}
      exit 0
      ;;
    
    -v|--version)
      shift
      userVersion=$1
      shift
      ;;
      
    -o|--output)
      shift
      userOutput=$1
      shift
      ;;
      
    -m)
      shift
      userType=$1
      shift
      ;;
      
    -nt)
      shift
      userType=0
      shift
      ;;
    *)
      userCmd+=("$1")
      shift
      ;;
  esac
done

runCmd "${userCmd[@]}"