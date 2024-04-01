Source folder should contain `.png` files named accroding to `iconutil` format. i.e.

* `icon_1024x1024.png`
* `icon_512x512.png`
* `icon_96x96.png`
* `icon_256x256.png`
* `icon_32x32.png`
* `icon_48x48.png`
* `icon_16x16.png`
* `icon_24x24.png`

The files are used to create a composite `.ico` file. They are also passed to `iconutil` on Mac to create a composite `.icns` file.

The resolution directives are ignored on Windows. e.g.

* `icon_512x512@2x.png`
* `icon_256x256@2x.png`
* `icon_512x512.png`
* `icon_256x256.png`
* `icon_128x128.png`
* `icon_128x128@2x.png`
* `icon_32x32.png`
* `icon_32x32@2x.png`
* `icon_16x16.png`
* `icon_16x16@2x.png`

# Acknowledgements

* [J-Siu/go-png2ico](https://github.com/J-Siu/go-png2ico)
