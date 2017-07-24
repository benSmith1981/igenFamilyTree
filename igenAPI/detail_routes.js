var detailController = require('./detail_controller') 

module.exports = function(routes) {
// Creates endpoint handlers for /users
	routes.route('/gettree/:patientID?')
	  .get(detailController.gettree)

	routes.route('/edithuman/:id?')
	  .post(detailController.edithuman)

	// routes.route('/savetree/:treeid?/:treedata?')
	routes.route('/savetree/')
	  .post(detailController.savetree)
}