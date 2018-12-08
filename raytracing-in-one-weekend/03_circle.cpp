#include <iostream>
#include <math.h>

class vec3  {   
public:
    vec3() {}
    vec3(float e0, float e1, float e2) { e[0] = e0; e[1] = e1; e[2] = e2; }
       
    float e[3];
};

inline vec3 operator+(const vec3 &v1, const vec3 &v2) {
    return vec3(v1.e[0] + v2.e[0], v1.e[1] + v2.e[1], v1.e[2] + v2.e[2]);
}

bool hit_sphere(float u, float v) {
    float d1 = -2.0 + 4.0*u;
    float d2 = -1.0 + 2.0*v;
    float d3 = 1.0;

    float a = d1*d1 + d2*d2 + d3*d3;
    float discriminant = 4.0 - 3.0*a;
    return discriminant > 0;
}

vec3 color(float u, float v) {
    if(hit_sphere(u,v)) {
	return vec3(1, 0, 0);
    }
    
    vec3 lower_left_corner(-2.0, -1.0, 1.0);
    vec3 horizontal(4.0, 0.0, 0.0);
    vec3 vertical(0.0, 2.0, 0.0);

    vec3 B(lower_left_corner.e[0] + u*horizontal.e[0] + v*vertical.e[0],
	   lower_left_corner.e[1] + u*horizontal.e[1] + v*vertical.e[1],
	   lower_left_corner.e[2] + u*horizontal.e[2] + v*vertical.e[2]);
    
    float len = sqrt(B.e[0]*B.e[0] + B.e[1]*B.e[1] + B.e[2]*B.e[2]);
    float unit_direction = B.e[1]/len;
    float t = 0.5*unit_direction + 0.5;
    
    return vec3((1.0-t) * 1.0 + t*0.5,
		(1.0-t) * 1.0 + t*0.7,
		(1.0-t) * 1.0 + t*1.0);
}

int main() {
    int nx = 200;
    int ny = 100;
    std::cout << "P3\n" << nx << " " << ny << "\n255\n";

    for(int j = ny-1; j >= 0; j--) {
	for (int i = 0; i < nx; i++) {
	    float u = float(i) / float(nx);
	    float v = float(j) / float(ny);
	    
	    vec3 col = color(u, v);
	    
	    int ir = int(255.99*col.e[0]);
	    int ig = int(255.99*col.e[1]);
	    int ib = int(255.99*col.e[2]);

	    std::cout << ir << " " << ig << " " << ib << "\n";
	}
    }
    
    return 0;
}
