enum StatusRequest {
  loading ,                        // loading
  success ,                        //  En cas de succès
  failure ,                       // email or phone  already exist  non data 
  serverfailure ,                  //// En cas de problème serveur 404
  serverException ,
  offlinefailure,                 // Erreur réseau ou connexion internet
  invalidData,
  error,
  noProducts, none, // Ajoute cette ligne
}