{dynamic}
{if $error}
  <div class="rubrique">
    Derni�re �tape
  </div>
  <p>
    Tu as maintenant acc�s au site en utilisant les param�tres re�us par mail.
    Les adresses �lectroniques <strong>{$username}@polytechnique.org</strong>
    et <strong>{$username}@m4x.org</strong> sont d�j� ouvertes, essaie-les !
  </p>
  <p>
    Remarque: m4x.org est un domaine "discret" qui veut dire "mail for X" et
    qui comporte exactement les m�mes adresses que le domaine polytechnique.org.
  </p>
  <p>
    <strong><a href="{if $dev eq 0}https://www.polytechnique.org/{/if}motdepassemd5.php">Clique ici pour changer ton mot de passe.</a></strong>
  </p>
  <p>
    N'oublie pas : si tu perds ton mot de passe, nous n'avons aucun engagement, en
    particulier en termes de rapidit�, mais pas seulement, � te redonner acc�s au
    site. Cela peut prendre plusieurs semaines, les pertes de mot de passe sont
    trait�es avec la priorit� minimale.
  </p>
{elseif $error eq $smarty.const.ERROR_DB}
  {$error_db}

  <p>
    Une erreur s'est produite lors de la mise en place d�finitive de ton inscription,
    essaie � nouveau, si cela ne fonctionne toujours pas, envoie un mail �
    <a href="mailto:webmestre@polytechnique.org">webmaster@polytechnique.org</a>
  </p>
{elseif $error eq $smarty.const.ERROR_ALREADY_SUBSCRIBED}
  <p>
    Tu es d�j� inscrit � polytechnique.org. Tu as s�rement cliqu� deux fois sur le m�me lien de
    r�f�rence ou effectu� un double clic. Consultes tes mails pour obtenir ton identifiant et ton
    mot de passe.
  </p>
{elseif $error eq $smarty.const.ERROR_REF}
  <div class="rubrique">
    OOOooups !
  </div>
  <p>
    Cette adresse n'existe pas, ou plus, sur le serveur.
  </p>
  <p>
    Causes probables :
  </p>
  <ol>
    <li>
      V�rifie que tu visites l'adresse du dernier e-mail re�u s'il y en a eu plusieurs.
    </li>
    <li>
      Tu as peut-�tre mal copi� l'adresse re�ue par mail, v�rifie-la � la main.
    </li>
    <li>
      Tu as peut-�tre attendu trop longtemps pour confirmer. Les
      pr�-inscriptions sont annul�es tous les 30 jours.
    </li>
  </ol>
{/if}
{/dynamic}
