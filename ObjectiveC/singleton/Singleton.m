@implementation MySingleton

static MySingleton* _sharedMySingleton = nil;
 
+(MySingleton*)sharedMySingleton
{
	@synchronized([MySingleton class])
	{
		if (!_sharedMySingleton)
			[[self alloc] init];
 
		return _sharedMySingleton;
	}
 
	return nil;
}
 
+(id)alloc
{
	@synchronized([MySingleton class])
	{
		NSAssert(_sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedMySingleton = [super alloc];
		return _sharedMySingleton;
	}
 
	return nil;
}
 
-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
 
	return self;
}
@end