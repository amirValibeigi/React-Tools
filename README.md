# React-Tools

tools for react native

## using

you can use full or short commands, such as:

release apk

```bash
ReactTools build release
```

or

```bash
ReactTools b r
```

---

## build

- debug - build debug apk without sign key

```bash
ReactTools b
```

```bash
ReactTools b d
```

- release - build release apk wit sign key

```bash
ReactTools b r
```

## check

- require - check requirements react-native

```bash
ReactTools c r
```

## install

- react **{NAME_PROJECT}** - install react-native project with custom template

  **-v=0.64.2** version react

  **-nt** create without custom template

```bash
ReactTools i r TestReactTools -v 0.65.0
```

- app **{FOLDER}/{NAME_APK}** - install apk on all devices

  **-p=android/app/build/outputs/apk** path apk

```bash
ReactTools i a debug/app-x86_64-release.apk
```

- app debug - install app-debug.apk on all devices

```bash
ReactTools i a
```

- app release - install app-release.apk on all devices

```bash
ReactTools i a r
```

## make

- src - make folders for react-native

  **-o** path make src

```bash
ReactTools m s
```

## start

- adb - connect to device **def=usb**

- adb:clear **{PACKAGE_NAME}** - clear and run app

  **-p** path project

```bash
ReactTools s a:c
```

or

```bash
ReactTools s a:c com.example.test
```

- adb:usb - connect to device with usb
- adb:wifi **{ADDRESS:PORT}** - connect to device with wifi

```bash
ReactTools s a:wifi 192.168.1.101
```

- react:link - link library

```bash
ReactTools s r:l
```

- react:openDeveloper - open react developer dialog

```bash
ReactTools s r:od
```

- server - start server react-native

```bash
ReactTools s s
```

or

```bash
ReactTools s
```
