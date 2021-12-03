# React-Tools

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

## make

- src - make folders for react-native

  **-o** path make src

```bash
  ReactTools m s
```

## start

- adb - connect to device **def=usb**

- adb:usb - connect to device with usb
- adb:wifi **{ADDRESS:PORT}** - connect to device with wifi

```bash
ReactTools s a:wifi 192.168.1.101
```

- server - start server react-native

```bash
ReactTools s s| ReactTools s
```
