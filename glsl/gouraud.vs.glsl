//  http://www.cs.toronto.edu/~jacobson/phong-demo/  used as template

//LIGHTING PROPERTIES
uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightPosition;
////MATERIAL PROPERTIES 
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

varying vec4 V_Color;

void main() {
	// COMPUTE COLOR ACCORDING TO GOURAUD HERE
	// ambient
	vec3 ambient = ambientColor;
	// Diffuse 
	vec4 vertPos4 = modelViewMatrix * vec4(position, 1.0);
	vec3 vertPos3 = vec3(vertPos4.xyz);
	vec4 lightVector = (viewMatrix * vec4(lightPosition, 0.0));
	vec3 lightVector3 = normalize(vec3(lightVector.x, lightVector.y, lightVector.z));
	vec3 normalizedNormal = normalize(normal);
	float NLAngle = max(0.0, dot(normalizedNormal, lightVector3));
	vec3 diffuse = lightColor * NLAngle;

	// Specular
	vec3 reflectionVector = reflect(-lightVector3, normalizedNormal);
	vec3 viewVector = normalize(-vertPos3); // ?
	float specAmount = pow(max(0.0, dot(reflectionVector, viewVector)), shininess);
	vec3 specular = specAmount * lightColor;
	
	// final color
	vec4 finalColor = vec4(kAmbient * ambient + kDiffuse * diffuse + kSpecular * specular, 1.0);
	vec4 V_Color_Ambient = vec4(kAmbient * ambient, 1.0);
	vec4 V_Color_Diffuse = vec4(kDiffuse * diffuse, 1.0);
	vec4 V_Color_specular = vec4(kSpecular * specular, 1.0);

	V_Color = finalColor;


	// Position
	gl_Position = projectionMatrix *  modelViewMatrix * vec4(position, 1.0);
}