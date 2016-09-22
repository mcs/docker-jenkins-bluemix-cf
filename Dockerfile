FROM jenkins
USER root
RUN cd /tmp \
	&& curl -L "https://cli.run.pivotal.io/stable?release=debian64&source=github" -o cf-cli-installer.deb \
	&& dpkg -i cf-cli-*.deb \
	&& apt-get install -f \
	&& curl -L "http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/Bluemix_CLI_0.4.2_amd64.tar.gz" -o bluemix-cli.tar.gz \
	&& tar xzf bluemix-cli.tar.gz \
	&& cd Bluemix_CLI \
	&& ./install_bluemix_cli

USER jenkins

