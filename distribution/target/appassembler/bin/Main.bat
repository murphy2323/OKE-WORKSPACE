@REM ----------------------------------------------------------------------------
@REM  Copyright 2001-2006 The Apache Software Foundation.
@REM
@REM  Licensed under the Apache License, Version 2.0 (the "License");
@REM  you may not use this file except in compliance with the License.
@REM  You may obtain a copy of the License at
@REM
@REM       http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM  Unless required by applicable law or agreed to in writing, software
@REM  distributed under the License is distributed on an "AS IS" BASIS,
@REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM  See the License for the specific language governing permissions and
@REM  limitations under the License.
@REM ----------------------------------------------------------------------------
@REM
@REM   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
@REM   reserved.

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
set BASEDIR=%~dp0\..

:repoSetup
set REPO=


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\repo

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\com\example\personsdb\0.0.1-SNAPSHOT\personsdb-0.0.1-SNAPSHOT.jar;"%REPO%"\com\oracle\ojdbc8\12.2.0.1\ojdbc8-12.2.0.1.jar;"%REPO%"\org\eclipse\persistence\eclipselink\2.6.2\eclipselink-2.6.2.jar;"%REPO%"\org\eclipse\persistence\commonj.sdo\2.1.1\commonj.sdo-2.1.1.jar;"%REPO%"\javax\validation\validation-api\1.1.0.Final\validation-api-1.1.0.Final.jar;"%REPO%"\org\eclipse\persistence\javax.persistence\2.1.0\javax.persistence-2.1.0.jar;"%REPO%"\com\demo\people-helidon\0.0.1-SNAPSHOT\people-helidon-0.0.1-SNAPSHOT.jar;"%REPO%"\io\helidon\webserver\helidon-webserver\0.10.1\helidon-webserver-0.10.1.jar;"%REPO%"\io\helidon\common\helidon-common-reactive\0.10.1\helidon-common-reactive-0.10.1.jar;"%REPO%"\io\helidon\common\helidon-common\0.10.1\helidon-common-0.10.1.jar;"%REPO%"\io\helidon\common\helidon-common-http\0.10.1\helidon-common-http-0.10.1.jar;"%REPO%"\io\helidon\config\helidon-config\0.10.1\helidon-config-0.10.1.jar;"%REPO%"\io\helidon\common\helidon-common-key-util\0.10.1\helidon-common-key-util-0.10.1.jar;"%REPO%"\io\helidon\common\helidon-common-configurable\0.10.1\helidon-common-configurable-0.10.1.jar;"%REPO%"\io\opentracing\opentracing-util\0.31.0\opentracing-util-0.31.0.jar;"%REPO%"\io\opentracing\opentracing-api\0.31.0\opentracing-api-0.31.0.jar;"%REPO%"\io\opentracing\opentracing-noop\0.31.0\opentracing-noop-0.31.0.jar;"%REPO%"\io\helidon\webserver\helidon-webserver-netty\0.10.1\helidon-webserver-netty-0.10.1.jar;"%REPO%"\io\netty\netty-codec-http\4.1.22.Final\netty-codec-http-4.1.22.Final.jar;"%REPO%"\io\netty\netty-codec\4.1.22.Final\netty-codec-4.1.22.Final.jar;"%REPO%"\io\netty\netty-handler\4.1.22.Final\netty-handler-4.1.22.Final.jar;"%REPO%"\io\netty\netty-buffer\4.1.22.Final\netty-buffer-4.1.22.Final.jar;"%REPO%"\io\netty\netty-common\4.1.22.Final\netty-common-4.1.22.Final.jar;"%REPO%"\io\netty\netty-transport\4.1.22.Final\netty-transport-4.1.22.Final.jar;"%REPO%"\io\netty\netty-resolver\4.1.22.Final\netty-resolver-4.1.22.Final.jar;"%REPO%"\io\helidon\microprofile\bundles\helidon-microprofile-1.2\0.10.1\helidon-microprofile-1.2-0.10.1.jar;"%REPO%"\io\helidon\microprofile\bundles\helidon-microprofile-1.1\0.10.1\helidon-microprofile-1.1-0.10.1.jar;"%REPO%"\io\helidon\microprofile\server\helidon-microprofile-server\0.10.1\helidon-microprofile-server-0.10.1.jar;"%REPO%"\org\jboss\weld\se\weld-se-core\3.0.3.Final\weld-se-core-3.0.3.Final.jar;"%REPO%"\org\jboss\weld\environment\weld-environment-common\3.0.3.Final\weld-environment-common-3.0.3.Final.jar;"%REPO%"\org\jboss\weld\weld-core-impl\3.0.3.Final\weld-core-impl-3.0.3.Final.jar;"%REPO%"\org\jboss\weld\weld-api\3.0.SP2\weld-api-3.0.SP2.jar;"%REPO%"\org\jboss\weld\weld-spi\3.0.SP2\weld-spi-3.0.SP2.jar;"%REPO%"\org\jboss\spec\javax\el\jboss-el-api_3.0_spec\1.0.7.Final\jboss-el-api_3.0_spec-1.0.7.Final.jar;"%REPO%"\org\jboss\spec\javax\interceptor\jboss-interceptors-api_1.2_spec\1.0.0.Final\jboss-interceptors-api_1.2_spec-1.0.0.Final.jar;"%REPO%"\org\jboss\logging\jboss-logging\3.2.1.Final\jboss-logging-3.2.1.Final.jar;"%REPO%"\org\jboss\weld\probe\weld-probe-core\3.0.3.Final\weld-probe-core-3.0.3.Final.jar;"%REPO%"\org\jboss\classfilewriter\jboss-classfilewriter\1.2.1.Final\jboss-classfilewriter-1.2.1.Final.jar;"%REPO%"\org\slf4j\slf4j-api\1.7.25\slf4j-api-1.7.25.jar;"%REPO%"\org\slf4j\slf4j-jdk14\1.7.25\slf4j-jdk14-1.7.25.jar;"%REPO%"\org\glassfish\jersey\ext\cdi\jersey-weld2-se\2.26\jersey-weld2-se-2.26.jar;"%REPO%"\org\glassfish\jersey\ext\cdi\jersey-cdi1x\2.26\jersey-cdi1x-2.26.jar;"%REPO%"\org\glassfish\jersey\media\jersey-media-json-processing\2.26\jersey-media-json-processing-2.26.jar;"%REPO%"\org\glassfish\jsonp-jaxrs\1.1.1\jsonp-jaxrs-1.1.1.jar;"%REPO%"\io\helidon\microprofile\config\helidon-microprofile-config\0.10.1\helidon-microprofile-config-0.10.1.jar;"%REPO%"\io\helidon\config\helidon-config-bundle\0.10.1\helidon-config-bundle-0.10.1.jar;"%REPO%"\io\helidon\config\helidon-config-hocon\0.10.1\helidon-config-hocon-0.10.1.jar;"%REPO%"\com\typesafe\config\1.3.3\config-1.3.3.jar;"%REPO%"\io\helidon\config\helidon-config-yaml\0.10.1\helidon-config-yaml-0.10.1.jar;"%REPO%"\org\yaml\snakeyaml\1.19\snakeyaml-1.19.jar;"%REPO%"\io\helidon\security\helidon-security-tools-config\0.10.1\helidon-security-tools-config-0.10.1.jar;"%REPO%"\io\helidon\microprofile\config\helidon-microprofile-config-cdi\0.10.1\helidon-microprofile-config-cdi-0.10.1.jar;"%REPO%"\io\helidon\microprofile\health\helidon-microprofile-health-core\0.10.1\helidon-microprofile-health-core-0.10.1.jar;"%REPO%"\org\eclipse\microprofile\config\microprofile-config-api\1.2.1\microprofile-config-api-1.2.1.jar;"%REPO%"\org\osgi\org.osgi.annotation.versioning\1.0.0\org.osgi.annotation.versioning-1.0.0.jar;"%REPO%"\org\eclipse\microprofile\health\microprofile-health-api\1.0\microprofile-health-api-1.0.jar;"%REPO%"\javax\inject\javax.inject\1\javax.inject-1.jar;"%REPO%"\io\helidon\microprofile\health\helidon-microprofile-health-checks\0.10.1\helidon-microprofile-health-checks-0.10.1.jar;"%REPO%"\io\helidon\microprofile\metrics\helidon-microprofile-metrics-cdi\0.10.1\helidon-microprofile-metrics-cdi-0.10.1.jar;"%REPO%"\javax\enterprise\cdi-api\2.0\cdi-api-2.0.jar;"%REPO%"\javax\el\javax.el-api\3.0.0\javax.el-api-3.0.0.jar;"%REPO%"\javax\interceptor\javax.interceptor-api\1.2\javax.interceptor-api-1.2.jar;"%REPO%"\io\helidon\microprofile\metrics\helidon-microprofile-metrics\0.10.1\helidon-microprofile-metrics-0.10.1.jar;"%REPO%"\io\helidon\microprofile\metrics\helidon-metrics-se\0.10.1\helidon-metrics-se-0.10.1.jar;"%REPO%"\org\eclipse\microprofile\metrics\microprofile-metrics-api\1.1\microprofile-metrics-api-1.1.jar;"%REPO%"\io\helidon\webserver\helidon-webserver-json\0.10.1\helidon-webserver-json-0.10.1.jar;"%REPO%"\io\helidon\webserver\helidon-webserver-jersey\0.10.1\helidon-webserver-jersey-0.10.1.jar;"%REPO%"\org\glassfish\jersey\core\jersey-server\2.26\jersey-server-2.26.jar;"%REPO%"\javax\annotation\javax.annotation-api\1.3.1\javax.annotation-api-1.3.1.jar;"%REPO%"\org\glassfish\jersey\inject\jersey-hk2\2.26\jersey-hk2-2.26.jar;"%REPO%"\org\glassfish\hk2\hk2-locator\2.5.0-b42\hk2-locator-2.5.0-b42.jar;"%REPO%"\org\glassfish\hk2\external\aopalliance-repackaged\2.5.0-b42\aopalliance-repackaged-2.5.0-b42.jar;"%REPO%"\org\glassfish\hk2\hk2-api\2.5.0-b42\hk2-api-2.5.0-b42.jar;"%REPO%"\org\glassfish\hk2\hk2-utils\2.5.0-b42\hk2-utils-2.5.0-b42.jar;"%REPO%"\org\javassist\javassist\3.22.0-CR2\javassist-3.22.0-CR2.jar;"%REPO%"\io\projectreactor\reactor-core\3.1.5.RELEASE\reactor-core-3.1.5.RELEASE.jar;"%REPO%"\org\reactivestreams\reactive-streams\1.0.2\reactive-streams-1.0.2.jar;"%REPO%"\org\glassfish\javax.json\1.1.2\javax.json-1.1.2.jar;"%REPO%"\javax\json\javax.json-api\1.1.2\javax.json-api-1.1.2.jar;"%REPO%"\org\glassfish\jersey\media\jersey-media-moxy\2.26\jersey-media-moxy-2.26.jar;"%REPO%"\org\glassfish\jersey\core\jersey-common\2.26\jersey-common-2.26.jar;"%REPO%"\org\glassfish\hk2\external\javax.inject\2.5.0-b42\javax.inject-2.5.0-b42.jar;"%REPO%"\org\glassfish\hk2\osgi-resource-locator\1.0.1\osgi-resource-locator-1.0.1.jar;"%REPO%"\org\glassfish\jersey\ext\jersey-entity-filtering\2.26\jersey-entity-filtering-2.26.jar;"%REPO%"\org\eclipse\persistence\org.eclipse.persistence.moxy\2.6.4\org.eclipse.persistence.moxy-2.6.4.jar;"%REPO%"\org\eclipse\persistence\org.eclipse.persistence.core\2.6.4\org.eclipse.persistence.core-2.6.4.jar;"%REPO%"\org\eclipse\persistence\org.eclipse.persistence.asm\2.6.4\org.eclipse.persistence.asm-2.6.4.jar;"%REPO%"\io\helidon\security\helidon-security-integration-jersey\0.10.1\helidon-security-integration-jersey-0.10.1.jar;"%REPO%"\io\helidon\security\helidon-security\0.10.1\helidon-security-0.10.1.jar;"%REPO%"\io\helidon\security\helidon-security-integration-annotations\0.10.1\helidon-security-integration-annotations-0.10.1.jar;"%REPO%"\io\helidon\security\helidon-security-util\0.10.1\helidon-security-util-0.10.1.jar;"%REPO%"\javax\ws\rs\javax.ws.rs-api\2.1\javax.ws.rs-api-2.1.jar;"%REPO%"\org\glassfish\jersey\core\jersey-client\2.26\jersey-client-2.26.jar;"%REPO%"\io\helidon\security\helidon-security-provider-http-auth\0.10.1\helidon-security-provider-http-auth-0.10.1.jar;"%REPO%"\io\helidon\security\helidon-security-providers-common\0.10.1\helidon-security-providers-common-0.10.1.jar;"%REPO%"\io\helidon\security\helidon-security-integration-webserver\0.10.1\helidon-security-integration-webserver-0.10.1.jar;"%REPO%"\io\helidon\webserver\helidon-webserver-zipkin\0.10.1\helidon-webserver-zipkin-0.10.1.jar;"%REPO%"\io\zipkin\reporter2\zipkin-sender-urlconnection\2.6.0\zipkin-sender-urlconnection-2.6.0.jar;"%REPO%"\io\zipkin\reporter2\zipkin-reporter\2.6.0\zipkin-reporter-2.6.0.jar;"%REPO%"\io\zipkin\zipkin2\zipkin\2.8.1\zipkin-2.8.1.jar;"%REPO%"\io\opentracing\brave\brave-opentracing\0.31.0\brave-opentracing-0.31.0.jar;"%REPO%"\io\zipkin\brave\brave\5.0.0\brave-5.0.0.jar;"%REPO%"\com\demo\distribution\0.0.1-SNAPSHOT\distribution-0.0.1-SNAPSHOT.jar

set ENDORSED_DIR=
if NOT "%ENDORSED_DIR%" == "" set CLASSPATH="%BASEDIR%"\%ENDORSED_DIR%\*;%CLASSPATH%

if NOT "%CLASSPATH_PREFIX%" == "" set CLASSPATH=%CLASSPATH_PREFIX%;%CLASSPATH%

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS%  -classpath %CLASSPATH% -Dapp.name="Main" -Dapp.repo="%REPO%" -Dapp.home="%BASEDIR%" -Dbasedir="%BASEDIR%" com.demo.helidon.Main %CMD_LINE_ARGS%
if %ERRORLEVEL% NEQ 0 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=%ERRORLEVEL%

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@REM If error code is set to 1 then the endlocal was done already in :error.
if %ERROR_CODE% EQU 0 @endlocal


:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
