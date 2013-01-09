#!/bin/bash
#
# bl4de <bloorq@gmail.com>
#
# simple new ZF2 module's folder structure
#
# Copy this script to root dir of ZF2 application.
# Usage: ./zf2crmod module_name [options]
#	options:
#	-f force creating new module (if module exists, will be deleted !!!)
#
# FFTUTSAYN Licence:
# Feel free to use this script as You need...  :)
#
if [[ $1 == "" ]]; then
	echo -e "Usage: ./zf2crmod module_name [options]\n'module_name' must be specified!\n\n"
	exit 1;
fi

module_name=$1;

# create module's folder structure and conf files
cd module/
if [[ $2 == "-f" ]]; then
	echo -e "forcing delete $module_name directory..."
	rm -rf $module_name
	echo -e "deleted"
fi
if [[ -d $module_name ]]; then
	echo -e "module $module_name already exists";
	exit 1;
fi

echo -e "create new $module_name ZF2 module, this will take a while..."
mkdir $module_name
cd $module_name
mkdir config/ language/ src/ view/
cd config;
touch module.config.php;
echo -e "<?php\nnamespace $module_name;\n\nreturn array();\n\n" >> module.config.php;
cd ../src
mkdir $module_name; cd $module_name; mkdir Controller/ Form/ Model/
cd Controller;
touch IndexController.php;
echo -e "<?php\nnamespace $module_name\Controller;\nuse Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;\n\nclass IndexController extends AbstractActionController {
\tpublic function indexAction() {\n\t\treturn new ViewModel(array());\n\t}\n}" >> IndexController.php;
cd ../../../
touch Module.php;
echo -e "<?php\nnamespace $module_name;\n\nuse Zend\\Mvc\\ModuleRouteListener;\nuse Zend\\Mvc\\MvcEvent;" >> Module.php;
echo -e "\n\nclass Module {\n" >> Module.php;
echo -e "\tpublic function getConfig() {\n\t\treturn include __DIR__ . '/config/module.config.php';\n\t}" >> Module.php;
echo -e "\n\n\tpublic function getAutoloaderConfig() {\n\t\treturn array(\n\t\t\t'Zend\Loader\StandardAutoloader'" >> Module.php;
echo -e " => array(\n\t\t\t\t'namespaces' => array(\n\t\t\t\t\t __NAMESPACE__ => __DIR__ . '/src/' . __NAMESPACE__," >> Module.php;
echo -e "\n\t\t\t\t),\n\t\t\t),\n\t\t);\n\t}\n}\n\n" >> Module.php;

echo -e "Done.";


