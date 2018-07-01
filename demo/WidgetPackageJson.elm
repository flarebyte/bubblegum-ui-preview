module WidgetPackageJson exposing (meta)

import PackageJson


meta : PackageJson.Model
meta =
    { version = "1.0.0"
    , summary = "Preview widget for the Bubblegum UI toolkit."
    , repository = "https://github.com/flarebyte/bubblegum-ui-preview.git"
    , license = "BSD3"
    , exposedModules = [ "Bubblegum.Preview.Widget" ]
    }
