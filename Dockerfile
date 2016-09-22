# (C) Copyright Hamburger Sparkasse 2016.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This image bundle latest Jenkins with Cloud Foundry and Bluemix CLI tools.

FROM jenkins:latest

MAINTAINER Marcus Krassmann <krassmann@silpion.de>

USER root

RUN cd /tmp \
	&& apt-get update \
	&& apt-get install -y build-essential \
	&& curl -L https://deb.nodesource.com/setup_6.x | bash - \
	&& apt-get install -y nodejs \
	&& curl -L "https://cli.run.pivotal.io/stable?release=debian64&source=github" -o cf-cli-installer.deb \
	&& dpkg -i cf-cli-*.deb \
	&& apt-get install -f \
	&& curl -L "http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/Bluemix_CLI_0.4.2_amd64.tar.gz" -o bluemix-cli.tar.gz \
	&& tar xzf bluemix-cli.tar.gz \
	&& cd Bluemix_CLI \
	&& ./install_bluemix_cli \
	&& chmod go+wX /opt

USER jenkins

RUN cd /tmp \
	&& curl -L "http://www-us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz" | tar xz \
	&& mv apache-maven-3* /opt/


# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000