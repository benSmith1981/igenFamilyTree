var treeController = require('./tree_controller'), 
loginController = require('./login_controller'),
diseaseController = require('./disease_controller') 

module.exports = function(routes) {
// LOGIN
	routes.route('/verifymember/')
	  .post(loginController.verifymember)
	routes.route('/register/')
	  .post(loginController.register)
	routes.route('/login/')
	  .post(loginController.login)
	routes.route('/addpatientsid/')
	  .put(loginController.addpatientsid)

//SAVING AND EDITING TREE
	routes.route('/gettree/:patientID?')
	  .get(treeController.gettree)

	routes.route('/edithuman/:id?')
	  .put(treeController.edithuman)

	// routes.route('/savetree/:treeid?/:treedata?')
	routes.route('/savetree/')
	  .post(treeController.savetree)

	  	// routes.route('/savetree/:treeid?/:treedata?')
	routes.route('/deletetree/:patientID?')
	  .get(treeController.deletetree)

//DISEASES
	routes.route('/adddiseases/:id?')
	  .put(diseaseController.adddiseases)

	routes.route('/deletediseases/:id?')
	  .get(diseaseController.deletediseases)

	routes.route('/getdiseases/:id?')
	  .get(diseaseController.getdiseases)


}