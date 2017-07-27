var detailController = require('./detail_controller') 

module.exports = function(routes) {
// LOGIN
	routes.route('/register/')
	  .post(detailController.register)
	routes.route('/login/')
	  .post(detailController.login)

//SAVING AND EDITING TREE
	routes.route('/gettree/:patientID?')
	  .get(detailController.gettree)

	routes.route('/edithuman/:id?')
	  .put(detailController.edithuman)

	// routes.route('/savetree/:treeid?/:treedata?')
	routes.route('/savetree/')
	  .post(detailController.savetree)

	  	// routes.route('/savetree/:treeid?/:treedata?')
	routes.route('/deletetree/:patientID?')
	  .get(detailController.deletetree)

//DISEASES
	routes.route('/adddiseases/:id?')
	  .put(detailController.adddiseases)

	routes.route('/deletediseases/:id?')
	  .get(detailController.deletediseases)

	routes.route('/getdiseases/:id?')
	  .get(detailController.getdiseases)


}