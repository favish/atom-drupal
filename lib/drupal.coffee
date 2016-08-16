fs = require 'fs'
module.exports =

  activate: (state) ->
    php = atom.packages.loadPackage('language-php')
    php.activate().then(@.doit)
  doit: ->
    if not atom.config.get('drupal.fileTypesPhp')
      defaults = "module,install,inc,test,profile"
      atom.config.set('drupal.fileTypesPhp', defaults)
    typeString = atom.config.get('drupal.fileTypesPhp')
    typeList = typeString.split(",")

    phpGrammar = atom.packages.getLoadedPackage('language-php').grammars[0]
    phpGrammar.fileTypes = phpGrammar.fileTypes.concat(typeList)

    scope = 'text.html.php.drupal'
    drupal7 = false
    drupal8 = false
    paths = atom.project.getPaths()

    for path in paths
      containsIncludes = fs.existsSync(path + '/includes') or fs.existsSync(path + '/public_html/includes')
      containsModules = fs.existsSync(path + '/modules') or fs.existsSync(path + '/public_html/modules')
      containsCore = fs.existsSync(path + '/core') or fs.existsSync(path + '/public_html/core')
      if containsIncludes and containsModules
        drupal7 = true
      if containsCore and containsModules
        drupal8 = true
    console.log(drupal7, drupal8)
    if drupal7
      scope += '.drupal7'
    else if drupal8
      scope += '.drupal8'
    phpGrammar.scopeName = scope
    phpGrammar.activate()
