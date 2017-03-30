/*
  Copyright © 13/05/2016 Shaps

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

import Foundation


/**
 *  Defines the components that make up a grid -- used for constructing a path from a grid
 */
public struct GridComponents : OptionSet {
  public let rawValue: Int
  public init(rawValue: Int) { self.rawValue = rawValue }
  
  /// Represents the outline of the grid
  public static var outline: GridComponents { return GridComponents(rawValue: 1 << 0) }
  
  /// Represents the column separators of a grid
  public static var columns: GridComponents { return GridComponents(rawValue: 1 << 1) }
  
  /// Represents the row separators of a grid
  public static var rows:    GridComponents { return GridComponents(rawValue: 1 << 2) }
  
  /// Represents all components
  public static var all:     GridComponents { return [ .outline, .columns, .rows ] }
}


/**
 *  Represents an entire row in a table
 */
public struct Row {
  public let bounds: CGRect
}

/**
 *  Represents an entire column in a table
 */
public struct Column {
  
  public let rows: [Row]
  public let bounds: CGRect
  
}

/**
 *  Represents columns and rows that make up a table
 */
public struct Grid {
  
  /// Returns the columns associated with this table
  public let columns: [Column]
  
  /// Returns the bounds for this table
  public let bounds: CGRect
  
  /**
   Creates a new table with the specified col/row counts
   
   - parameter colCount: The number of columns
   - parameter rowCount: The number of rows
   - parameter bounds:   The bounds for this table
   
   - returns: A new table
   */
  public init(colCount: Int, rowCount: Int, bounds: CGRect) {
    self.bounds = bounds
    var columns = [Column]()
    
    guard colCount > 0 || rowCount > 0 else {
      self.columns = columns
      return
    }
    
    for col in 0..<colCount {
      var rows = [Row]()
      let colWidth = self.bounds.width / CGFloat(colCount)
      let colRect = CGRect(x: self.bounds.minX + colWidth * CGFloat(col), y: self.bounds.minY, width: colWidth, height: self.bounds.height)
      
      for row in 0..<rowCount {
        let rowHeight = self.bounds.height / CGFloat(rowCount)
        let rowRect = CGRect(x: self.bounds.minX, y: self.bounds.minY + rowHeight * CGFloat(row), width: self.bounds.width, height: rowHeight)
        
        let row = Row(bounds: rowRect)
        rows.append(row)
      }
      
      let column = Column(rows: rows, bounds: colRect)
      columns.append(column)
    }
    
    self.columns = columns
  }
  
  /**
   Returns the column/row position for the specified cell index in the table
   
   - parameter index: The index of the cell to query
   
   - returns: The column and row representing this index
   */
  public func positionForCell(atIndex index: Int) -> (col: Int, row: Int) {
    let row = Int(ceil(CGFloat(index) / CGFloat(columns.count)))
    let col = Int(CGFloat(index % columns.count))
    return (col, row)
  }
  
  /**
   Returns the bounding rectangle for the cell at the specified index
   
   - parameter index: The index of the cell
   
   - returns: The bounding rectangle
   */
  public func boundsForCell(atIndex index: Int) -> CGRect {
    let (col, row) = positionForCell(atIndex: index)
    return boundsForCell(col: col, row: row)
  }
  
  /**
   Returns a bounding rectangle that contains both the source and destination cells
   
   - parameter sourceColumn:      The source column
   - parameter sourceRow:         The source row
   - parameter destinationColumn: The destination column
   - parameter destinationRow:    The destination row
   
   - returns: The bounding rectangle
   */
  public func boundsForRange(sourceColumn: Int, sourceRow: Int, destinationColumn: Int, destinationRow: Int) -> CGRect {
    let rect1 = boundsForCell(col: sourceColumn, row: sourceRow)
    let rect2 = boundsForCell(col: destinationColumn, row: destinationRow)
    return rect1.union(rect2)
  }
  
  /**
   Returns the bounding rectangle for a specific cell
   
   - parameter col: The column
   - parameter row: The row
   
   - returns: The bounding rectangle
   */
  public func boundsForCell(col: Int, row: Int) -> CGRect {
    guard col < columns.count else {
      return CGRect.zero
    }
    
    let colWidth = bounds.width / CGFloat(columns.count)
    let column = columns[col]
    
    guard row < column.rows.count else {
      return CGRect.zero
    }
    
    let row = column.rows[row]

    var rect = column.bounds
    
    rect.origin.y = row.bounds.minY
    rect.size.width = colWidth
    rect.size.height = bounds.height / CGFloat(column.rows.count)
    
    return rect
  }
  
  /**
   Enumerates all cells in the grid
   
   - parameter enumerator: The enumerator to execute for each cell -- returns the index, column, row and bounding rectangle representing this cell
   */
  public func enumerateCells(_ enumerator: (_ index: Int, _ col: Int, _ row: Int, _ bounds: CGRect) -> Void) {
    guard let column = columns.first else {
      return
    }
    
    let rowCount = column.rows.count
    var index = 0
    
    for rowIndex in 0..<rowCount {
      for colIndex in 0..<columns.count {
        let rect = boundsForCell(col: colIndex, row: rowIndex)
        enumerator(index, colIndex, rowIndex, rect)
        index += 1
      }
    }
  }
  
}

extension Grid {
  
  /**
   Returns a Bezier Path representation of the grid -- you can use this to stroke the path using one of InkKit's other methods
   
   - parameter components: The components to draw -- Outline, Columns, Rows
   
   - returns: A bezier path representation
   */
  public func path(include components: GridComponents) -> BezierPath {
    let path = CGMutablePath()
    
    if components.contains(.columns) {
      for (index, column) in self.columns.enumerated() {
        if index == 0 { continue }
        
        var origin = column.bounds.origin
        origin.y = column.bounds.maxY
        
        path.move(to: CGPoint(x: column.bounds.origin.x, y: column.bounds.origin.y))
        path.addLine(to: CGPoint(x: origin.x, y: origin.y))
      }
    }
    
    if components.contains(.rows) {
      if let column = self.columns.first {
        for (index, row) in column.rows.enumerated() {
          if index == 0 { continue }
          
          var origin = row.bounds.origin
          origin.x = row.bounds.maxX
          
          path.move(to: CGPoint(x: column.bounds.origin.x, y: row.bounds.origin.y))
          path.addLine(to: CGPoint(x: origin.x, y: origin.y))
        }
      }
    }
    
    if components.contains(.outline) {
      path.addRect(bounds)
    }
    
    return BezierPath(cgPath: path) 
  }
  
}


