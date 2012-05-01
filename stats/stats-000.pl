__DATA__

Example:

  Here is a sample file `box.poly' describing a square with a square hole:

    # A box with eight points in 2D, no attributes, no boundary marker.
    8 2 0 0
    # Outer box has these vertices:
     1   0 0
     2   0 3
     3   3 0
     4   3 3
    # Inner square has these vertices:
     5   1 1
     6   1 2
     7   2 1
     8   2 2
    # Five segments without boundary markers.
    5 0
     1   1 2          # Left side of outer box.
     2   5 7          # Segments 2 through 5 enclose the hole.
     3   7 8
     4   8 6
     5   6 5
    # One hole in the middle of the inner square.
    1
     1   1.5 1.5

  After this PSLG is triangulated by Triangle, the resulting triangulation
  consists of a .node and .ele file.  Here is the former, `box.1.node',
  which duplicates the points of the PSLG:

    8  2  0  0
       1    0  0
       2    0  3
       3    3  0
       4    3  3
       5    1  1
       6    1  2
       7    2  1
       8    2  2
    # Generated by triangle -pcBev box

  Here is the triangulation file, `box.1.ele'.

    8  3  0
       1       1     5     6
       2       5     1     3
       3       2     6     8
       4       6     2     1
       5       7     3     4
       6       3     7     5
       7       8     4     2
       8       4     8     7
    # Generated by triangle -pcBev box

  Here is the edge file for the triangulation, `box.1.edge'.

    16  0
       1   1  5
       2   5  6
       3   6  1
       4   1  3
       5   3  5
       6   2  6
       7   6  8
       8   8  2
       9   2  1
      10   7  3
      11   3  4
      12   4  7
      13   7  5
      14   8  4
      15   4  2
      16   8  7
    # Generated by triangle -pcBev box

  Here's a file `box.1.part' that partitions the mesh into four subdomains.

    8  4
       1    3
       2    3
       3    4
       4    4
       5    1
       6    1
       7    2
       8    2
    # Generated by slice -s4 box.1

  Here's a file `box.1.adj' that represents the resulting adjacencies.

    4
      9
      2
      2
      0
      2
      9
      0
      2
      2
      0
      9
      2
      0
      2
      2
      9

Display Speed:
File Formats:

  All files may contain comments prefixed by the character '#'.  Points,
  segments, holes, triangles, edges, and subdomains must be numbered
  consecutively, starting from either 1 or 0.  Whichever you choose, all
  input files must be consistent (for any single iteration number); if the
  nodes are numbered from 1, so must be all other objects.  Show Me
  automatically detects your choice while reading a .node (or .poly) file.
  Examples of these file formats are given below.

  .node files:
    First line:  <# of points> <dimension (must be 2)> <# of attributes>
                                           <# of boundary markers (0 or 1)>
    Remaining lines:  <point #> <x> <y> [attributes] [boundary marker]

    The attributes, which are typically floating-point values of physical
    quantities (such as mass or conductivity) associated with the nodes of
    a finite element mesh, are ignored by Show Me.  Show Me also ignores
    boundary markers.  See the instructions for Triangle to find out what
    attributes and boundary markers are.

  .poly files:
    First line:  <# of points> <dimension (must be 2)> <# of attributes>
                                           <# of boundary markers (0 or 1)>
    Following lines:  <point #> <x> <y> [attributes] [boundary marker]
    One line:  <# of segments> <# of boundary markers (0 or 1)>
    Following lines:  <segment #> <endpoint> <endpoint> [boundary marker]
    One line:  <# of holes>
    Following lines:  <hole #> <x> <y>
    [Optional additional lines that are ignored]

    A .poly file represents a Planar Straight Line Graph (PSLG), an idea
    familiar to computational geometers.  By definition, a PSLG is just a
    list of points and edges.  A .poly file also contains some additional
    information.

    The first section lists all the points, and is identical to the format
    of .node files.  <# of points> may be set to zero to indicate that the
    points are listed in a separate .node file; .poly files produced by
    Triangle always have this format.  When Show Me reads such a file, it
    also reads the corresponding .node file.

    The second section lists the segments.  Segments are edges whose
    presence in a triangulation produced from the PSLG is enforced.  Each
    segment is specified by listing the indices of its two endpoints.  This
    means that its endpoints must be included in the point list.  Each
    segment, like each point, may have a boundary marker, which is ignored
    by Show Me.

    The third section lists holes and concavities that are desired in any
    triangulation generated from the PSLG.  Holes are specified by
    identifying a point inside each hole.

  .ele files:
    First line:  <# of triangles> <points per triangle> <# of attributes>
    Remaining lines:  <triangle #> <point> <point> <point> ... [attributes]

    Points are indices into the corresponding .node file.  Show Me ignores
    all but the first three points of each triangle; these should be the
    corners listed in counterclockwise order around the triangle.  The
    attributes are ignored by Show Me.

  .edge files:
    First line:  <# of edges> <# of boundary markers (0 or 1)>
    Following lines:  <edge #> <endpoint> <endpoint> [boundary marker]

    Endpoints are indices into the corresponding .node file.  The boundary
    markers are ignored by Show Me.

    In Voronoi diagrams, one also finds a special kind of edge that is an
    infinite ray with only one endpoint.  For these edges, a different
    format is used:

        <edge #> <endpoint> -1 <direction x> <direction y>

    The `direction' is a floating-point vector that indicates the direction
    of the infinite ray.

  .part files:
    First line:  <# of triangles> <# of subdomains>
    Remaining lines:  <triangle #> <subdomain #>

    The set of triangles is partitioned by a .part file; each triangle is
    mapped to a subdomain.

  .adj files:
    First line:  <# of subdomains>
    Remaining lines:  <adjacency matrix entry>

    An .adj file represents adjacencies between subdomains (presumably
    computed by a partitioner).  The first line is followed by
    (subdomains X subdomains) lines, each containing one entry of the
    adjacency matrix.  A nonzero entry indicates that two subdomains are
    adjacent (share a point).


