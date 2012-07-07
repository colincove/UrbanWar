package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.*;
	public class rope extends Sprite {
		var body:b2Body;
		public var m_world:b2World;
		public var m_iterations:int=10;
		public var m_timeStep:Number=1.0/30.0;
		var mouseJoint:b2MouseJoint;
		var mousePVec:b2Vec2 = new b2Vec2();
		var bodyDef:b2BodyDef;
		var boxDef:b2PolygonDef;
		var circleDef:b2CircleDef;
		var revolute_joint:b2RevoluteJointDef=new b2RevoluteJointDef();
		var link:b2Body;
		public function rope(main:MovieClip)
		{
			addEventListener(Event.ENTER_FRAME, Update, false, 0, true,false, true);
			main.stage.addEventListener(MouseEvent.MOUSE_DOWN, createMouse,false, true);
			main.stage.addEventListener(MouseEvent.MOUSE_UP, destroyMouse,false, true);
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-100.0, -100.0);
			worldAABB.upperBound.Set(100.0, 100.0);
			var gravity:b2Vec2=new b2Vec2(0.0,10.0);
			var doSleep:Boolean=true;
			m_world=new b2World(worldAABB,gravity,doSleep);
			// debug draw start
			var m_sprite:Sprite;
			m_sprite = new Sprite();
			main.addChild(m_sprite);
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			m_sprite.addChild(dbgSprite);
			dbgDraw.m_sprite=m_sprite;
			dbgDraw.m_drawScale=30;
			dbgDraw.m_alpha=1;
			dbgDraw.m_fillAlpha=0.5;
			dbgDraw.m_lineThickness=1;
			dbgDraw.m_drawFlags=b2DebugDraw.e_shapeBit;
			m_world.SetDebugDraw(dbgDraw);
			// ceiling
			bodyDef = new b2BodyDef();
			bodyDef.position.x=8.5;
			bodyDef.position.y=0;
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(2, 0.5);
			boxDef.density=0;
			boxDef.friction=0.5;
			boxDef.restitution=0.2;
			body=m_world.CreateBody(bodyDef);
			body.CreateShape(boxDef);
			link=body;
			// rope
			for (var i:int = 1; i <= 10; i++) {
				// rope segment
				bodyDef = new b2BodyDef();
				bodyDef.position.x=8.5;
				bodyDef.position.y=i;
				boxDef = new b2PolygonDef();
				boxDef.SetAsBox(0.1, 0.5);
				boxDef.density=100;
				boxDef.friction=0.5;
				boxDef.restitution=0.2;
				body=m_world.CreateBody(bodyDef);
				body.CreateShape(boxDef);
				// joint
				revolute_joint.Initialize(link, body, new b2Vec2(8.5, i-0.5));
				m_world.CreateJoint(revolute_joint);
				body.SetMassFromShapes();
				// saving the reference of the last placed link
				link=body;
			}
			// final body
			bodyDef.position.x=8.5;
			bodyDef.position.y=11;
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(0.5,0.5);
			boxDef.density=2;
			boxDef.friction=0.5;
			boxDef.restitution=0.2;
			body=m_world.CreateBody(bodyDef);
			body.CreateShape(boxDef);
			revolute_joint.Initialize(link, body, new b2Vec2(8.5, 10.5));
			m_world.CreateJoint(revolute_joint);
			body.SetMassFromShapes();
		}
		public function createMouse(evt:MouseEvent):void {
			var body:b2Body=GetBodyAtMouse();
			if (body) {
				var mouseJointDef:b2MouseJointDef=new b2MouseJointDef  ;
				mouseJointDef.body1=m_world.GetGroundBody();
				mouseJointDef.body2=body;
				mouseJointDef.target.Set(mouseX/30, mouseY/30);
				mouseJointDef.maxForce=30000;
				mouseJointDef.timeStep=m_timeStep;
				mouseJoint=m_world.CreateJoint(mouseJointDef) as b2MouseJoint;
			}
		}
		public function destroyMouse(evt:MouseEvent):void {
			if (mouseJoint) {
				m_world.DestroyJoint(mouseJoint);
				mouseJoint=null;
			}
		}
		public function GetBodyAtMouse(includeStatic:Boolean=false):b2Body {
			var mouseXWorldPhys = (mouseX)/30;
			var mouseYWorldPhys = (mouseY)/30;
			mousePVec.Set(mouseXWorldPhys, mouseYWorldPhys);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set(mouseXWorldPhys - 0.001, mouseYWorldPhys - 0.001);
			aabb.upperBound.Set(mouseXWorldPhys + 0.001, mouseYWorldPhys + 0.001);
			var k_maxCount:int=10;
			var shapes:Array = new Array();
			var count:int=m_world.Query(aabb,shapes,k_maxCount);
			var body:b2Body=null;
			for (var i:int = 0; i < count; ++i) {
				if (shapes[i].GetBody().IsStatic()==false||includeStatic) {
					var tShape:b2Shape=shapes[i] as b2Shape;
					var inside:Boolean=tShape.TestPoint(tShape.GetBody().GetXForm(),mousePVec);
					if (inside) {
						body=tShape.GetBody();
						break;
					}
				}
			}
			return body;
		}
		public function Update(e:Event):void {
			m_world.Step(m_timeStep, m_iterations);
			if (mouseJoint) {
				var mouseXWorldPhys=mouseX/30;
				var mouseYWorldPhys=mouseY/30;
				var p2:b2Vec2=new b2Vec2(mouseXWorldPhys,mouseYWorldPhys);
				mouseJoint.SetTarget(p2);
			}

		}
	}
}