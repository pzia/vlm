Ce document décrit les étapes pour fabriquer une image virtualbox pour VLM.
Cf. UPDATE pour les opérations à réaliser pour mettre à jour une image existante.
Les opérations sont décrites pour une base debian/ubuntu.
0. Préparation locale
 * mise à jour de l'etc/host local (127.0.0.1 localhost vlm)

1. Installer une base server debian/ubuntu minimale
 * Choisir l'UTC
 * Choisir un clavier conforme au votre, car sinon vbox est perdu.
 * utilisateur de base : vlm / vlm
 * ajouter une synchro ntp régulière (toutes les heures, Vbox se décale quand vous mettez le PC en veille).
  * sudo ln -s /usr/sbin/ntpdate-debian /etc/cron.hourly/ntp
 
2. Exportation depuis un serveur de production/développement existant.
 * {{{./base/scripts/dump.sh}}}
 * NB: le dump est assez lourd à cause des racemaps et des traces.
 * poser le fichier vlmdump.sql.gz quelque part
 
3. Suivre les étapes d'installations comme documentées dans hosting/INSTALL, en tenant compte du contexte

4. Créer l'environnement lié au subversion
 * Utiliser la doc du wiki : http://dev.virtual-loup-de-mer.org/vlm/wiki/developpment
 * svn co http://dev.virtual-loup-de-mer.org/svn/vlm $VLMRACINE/svn
 * autoriser subversion à stocker votre mot de passe : 
    editer : ~/.subversion/servers
    ajouter {{{store-passwords = yes}}} dans {{{[Global]}}}
 * FIXME : crontab pour une mise à jour récurrente
 * hostname et vhost à créer : vlmtrunk, vlmbranch014, etc...
 
5. Nettoyage avant la photo
 * Nettoyer les bases mysql (status, logs, etc...)
 * Nettoyer TMP
 
