# Metrio LITE

Metrio LITE est une nouvelle application web qui permet de **remplir des formulaires** pour éventuellement générer des indicateurs environnementaux.

Voici l'état actuel de son API.

## Installation

L'API utilise les technologies suivantes:

* Ruby on Rails 5.1
* Ruby 2.4
* MongoDB

Les technologies utilisées peuvent être installées ainsi (sur Ubuntu/Debian):

    # MongoDB
    # Suivre les instructions de https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

    # Rbenv (outil pour installer Ruby)
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'source ~/.bashrc' >> ~/.bash_profile
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    type rbenv # => "rbenv is a function" (you may need to restart your shell)

    # Autres outils Rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec

    # Ruby
    rbenv install 2.4.2

    # Ruby gems
    gem install bundler
    bundle install

## Démarrage

Le serveur de l'API peut être démarré localement en console ainsi:

    rails s

## Fonctionnalités existantes

Puisque le développement de l'application est très récent, beaucoup de fonctionnalités sont manquantes. Voici les fonctionnalités actuelles de l'API:

* L'utilisateur peut accéder aux données à l'addresse `/inputs`.
* L'utilisateur peut remplir le formulaire et le soumettre à l'addresse `/inputs`, ce qui insère les données en DB.

Les données saisies ont le schéma suivant:

    date: Date
    value: Float
    note: String, 1024 caractères maximum

## Exemple de requête à l'API pour la création d'une donnée:

```
curl \
  -X POST "http://localhost:3000/inputs" \
  -H "accept: application/json" \
  -H "content-type: application/json" \
  -d "{ \
    \"date\": \"2020-01-01\", \
    \"note\": \"Ma donnée\", \
    \"value\": 1 \
  }"
```

## Nouvelles fonctionnalités

Voici la liste des fonctionnalités que nous voulons ajouter à l'application:

**Ajout d'un nouveau modèle `Form` et de son schéma**

Un form doit avoir le schéma suivant:

    key: String, unique
    name: String
    tags: Array (voir exemple de structure dans la gestion de la configuration)

* Un `Form` a plusieurs `inputs` et chaque `Input` a un `Form`.
* Les `tags` peuvent être gérés à votre guise.

**Gestion de la configuration des instances de `Form`**

* On veut pouvoir gérer la configuration des formulaires via un fichier YAML.
* Une Rake task doit nous permettre de synchroniser (création/mise à jour/suppression) les instances dans la DB.
* Chaque instance doit posséder une clé unique, un nom ainsi qu'une ou plusieurs catégories (`tags`).
* Ainsi, un `Input` possède une valeur pour chaque catégories définies dans la configuration d'un `Form`, et ceux-ci doivent être validées lors de l'enregistrement.

Suggestion de configuration d'un `Form`:

```
    - key: "foo"
      name: "Mon formulaire"
      tags:
        - name: "Déchet"
          choices: ["papier", "metal"]
        - name: "Devise"
          choices: ["euro", "dollar canadien", "yen"]
```

**Gestion des données saisies (`Input`) au niveau de l'API**

* On doit pouvoir aller chercher les données par `form` au lieu de récupérer toutes les données en même temps.
* Modifier la création de données en fonction des `forms`.
* On doit pouvoir modifier une donnée existante.
* On doit pouvoir supprimer une donnée existante.
* Les `tags` doivent maintenant être supportés pour la saisie de données.

**Validation des données saisies (`Input`)**

* Les données saisies doivent être validées dans le backend en fonction de la configuration de leur `form`.
* Les attributs sont tous obligatoires sauf pour `note`.
* Une donnée doit être unique pour un `form`, une `date` et des `tags` donnés.
* L'API doit faire parvenir les erreurs de saisie aux utilisateurs.

## Structure du projet

* Modèles: `app/models`
* Controlleurs: `app/controllers`
* Rake tasks: `lib/tasks`
* Routes: `config/routes`

## Liens externes

* https://www.rubyguides.com/2019/02/ruby-rake/
* https://guides.rubyonrails.org/association_basics.html
* https://guides.rubyonrails.org/routing.html
