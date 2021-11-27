#!/usr/bin/env sh


#############comands
cmds=(" help install makeSrc ")
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


helpMe(){
	echo -e "\e[38;2;0;150;150m\n help\t\t\t\e[38;2;150;150;150m-h|-help"
  echo -e "\e[38;2;0;150;150m makeSrc\t\t\t\e[38;2;150;150;150m-m mode (mini, \e[38;2;20;150;20mfull\e[38;2;150;150;150m)"
  echo -e "\e[38;2;0;150;150m install\t\t\e[38;2;150;150;150m-h|-help"
}

runCmd(){
  case $1 in
    help)
      helpMe
    ;;

    makeSrc)
      mkDirSrcReact

      if [ "$userType" = "full" ]; then
        createFilesReact
      else
        createFilesReact
      fi
    ;;

  esac 
}

mkDirSrcReact(){
  if [ -n "$userOutput" ]; then
    tmpOutput=$userOutput
  else
    tmpOutput="."
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
  if [ -n "$userOutput" ]; then
    tmpOutput="$userOutput/src"
  else
    tmpOutput="./src"
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

    
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      helpMe
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
    *)
      if [[ "${cmds[*]}" =~ " ${1} " ]]; then
          userCmd=$1
      else
          helpMe
          exit 0
      fi
      shift
      ;;
  esac
done

runCmd $userCmd