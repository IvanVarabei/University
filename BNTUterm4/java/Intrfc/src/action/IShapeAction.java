package action;
import entity.AbstractShape;

public interface IShapeAction extends ILineGroupAction {
	double computeSquare(AbstractShape shape);
}
