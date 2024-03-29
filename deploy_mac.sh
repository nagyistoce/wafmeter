#!/bin/bash
rm -fr WAFmeter.app
/Developer/Tools/Qt/qmake WAFmeter.pro -r -spec macx-g++ CONFIG+=release
make clean && make || exit
/Developer/Tools/Qt/lrelease WAFmeter_French.ts
SVNVERSION=$(svnversion -n . | sed s#\:#-#g)
echo "Generating version = $SVNVERSION"
sed s#VERSION#"$SVNVERSION"#g Info.plist > WAFmeter.app/Contents/Info.plist

echo "Generate .app"
cp WAFmeter_French.qm WAFmeter.app/Contents/MacOS/
cp /Developer/Applications/Qt/translations/qt_fr.qm WAFmeter.app/Contents/MacOS/
#cp -r doc WAFmeter.app/Contents/MacOS/

/Developer/Tools/Qt/macdeployqt WAFmeter.app -dmg
mv WAFmeter.dmg WAFmeter-MacOSX-build"$SVNVERSION".dmg

#/Developer/Tools/Qt/macdeployqt WAFmeter.app
#zip -r WAFmeter-MacOSX-build"$SVNVERSION".zip WAFmeter.app
echo
echo "done."


