//LIGHTING PROPERTIES
uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightPosition;
////MATERIAL PROPERTIES 
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

varying vec4 V_ViewPosition;
varying vec4 V_Normal_VCS;


void main() {

	// COMPUTE LIGHTING HERE
	// ambient
	vec3 ambient = ambientColor;
	// Diffuse 
	vec3 normalizedNormal = vec3(V_Normal_VCS.x, V_Normal_VCS.y, V_Normal_VCS.z);
	vec4 lightVector = viewMatrix * (vec4(lightPosition, 0.0));
	vec3 lightVector3 = normalize(vec3(lightVector.x, lightVector.y, lightVector.z));
	float NLAngle = max(0.0, dot(normalizedNormal , lightVector3));
	vec3 diffuse = lightColor * NLAngle;
	// Specular
	vec3 viewVector = normalize(-vec3(V_ViewPosition.x, V_ViewPosition.y, V_ViewPosition.z)); 
	vec3 halfVector = normalize((lightVector3 + viewVector) / 2.0);
	float specAmount = pow(max(0.0, dot(normalizedNormal, halfVector)), shininess);
	vec3 specular = specAmount * lightColor;

	// final color
	vec4 finalColor = vec4(kAmbient * ambient + kDiffuse * diffuse + kSpecular * specular, 1.0);
	vec4 V_Color_Ambient = vec4(kAmbient * ambient, 1.0);
	vec4 V_Color_Diffuse = vec4(kDiffuse * diffuse, 1.0);
	vec4 V_Color_specular = vec4(kSpecular * specular, 1.0);

	gl_FragColor = finalColor;
}