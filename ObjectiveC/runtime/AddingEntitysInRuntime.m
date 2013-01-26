

Class newClass = objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
objc_registerClassPair(newClass);

void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"L'Objet : %p", self);
    NSLog(@"La Classe : %@", [self class]);
	NSLog(@"La Superclass : %@", [self superclass])'
 
    NSLog(@"NSObject class is :%p", [NSObject class]);
    NSLog(@"NSObject meta class : %p", object_getClass([NSObject class]));
}