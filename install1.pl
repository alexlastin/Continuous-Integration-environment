#!/usr/bin/perl

sub remote_exec {
	my $command = shift;
	my $host = '52.208.11.219';
	my $pem_file = "ci.pem";
	my $ssh_cmd_prefix = "ssh -i ci.pem ec2-user\@$host ";
	my $remote_command = $ssh_cmd_prefix.'"'.$command.'"';
	print "Command: $command\n";
	print "Remote command: $remote_command\n";

	my $ret = `$remote_command`;
	print "Command output:\n$ret\n";
}





# Installing Jenkins
remote_exec('sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo');
remote_exec('sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key');
remote_exec('sudo yum -y install jenkins');
remote_exec('sudo /sbin/service jenkins status');
remote_exec('sudo chmod 777 /var/lib/jenkins');
remote_exec('echo 2.0 >/var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion');
remote_exec('sudo -u jenkins sed -i \'s/<useSecurity>true<\/useSecurity>/ <useSecurity>false<\/useSecurity>/g\' /var/lib/jenkins/config.xml');
remote_exec('sudo /sbin/service jenkins start');
remote_exec('sudo /sbin/chkconfig jenkins on');

# Installing Apache Web server (httpd)
remote_exec('sudo yum -y install httpd');
remote_exec('sudo /sbin/service httpd status');
remote_exec('sudo /sbin/service httpd start');
remote_exec('sudo /sbin/chkconfig httpd on');

# Installing Maven
remote_exec(wget http://apache.spinellicreations.com/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz);
remote_exec(tar -xvzf apache-maven-3.3.9-bin.tar.gz);
remote_exec(rm apache-maven-3.3.9-bin.tar.gz);

#Installing Nexus


remote_exec(wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz);
remote_exec(tar -xvzf nexus-latest-bundle.tar.gz);
remote_exec(rm nexus-latest-bundle.tar.gz);

#password wiki -- Val#nok1234

# Installing GIT
remote_exec('rpm -qa | grep git');
remote_exec('sudo yum -y install git');
remote_exec('git config --global user.email gutkin26@gmail.com')
remote_exec('git config --global user.name alex')
remote_exec('ssh-keygen -t rsa -C gutkin26@gmail.com')
remote_exec('sudo cat /home/<local-user>/.ssh/id_rsa.pub')
#remote_exec('')





# Installing Gerrit











# Main program - COPY PROJECT FROM GITHUB - CREATE LOCAL REPOSITORY ------------------ REWORK NEEDED 
#print("please enter repository name from github website");
#$git_repo_name = <>;
#remote_exec(git clone $git_repo_name);
#7) rpm -qa | grep git
#8) yum install git
#9) yum install wget
#10) sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
#11) sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
#12) sudo yum -y install jenkins
#13) service jenkins status
#echo 2.0 >/var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion
#sed -i 's/<useSecurity>true<\/useSecurity>/ <useSecurity>false<\/useSecurity>/g' /var/lib/jenkins/config.xml
#service jenkins start
#chkconfig jenkins on