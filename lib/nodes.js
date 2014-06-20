function StyleSheet(rules){
	this.rules = rules
}
exports.StyleSheet = StyleSheet

function Rule(selector, properties){
	this.selector = selector
	this.properties = properties
}
exports.Rule = Rule

function Property(name, value){
	this.name = name
	this.value = value
}
exports.Property = Property