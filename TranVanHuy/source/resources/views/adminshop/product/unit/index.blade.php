@extends('adminshop.mastershop')
@section('main')
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Đơn vị tính</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="{{ route('adminshop.index') }}">Trang chủ</a></li>
              <li class="breadcrumb-item active">Đơn vị tính</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="card">
        <div class="card-header">
          <a href="{{ route('adminshop.unit.create') }}">
            <h3 class="card-title">Thêm mới</h3>
          </a>
          <div class="card-tools">
            <form action="">
              <div class="input-group input-group-sm" style="width: 150px;">
                <input type="text" name="key" class="form-control float-right" placeholder="Tìm kiếm">
  
                <div class="input-group-append">
                  <button type="submit" class="btn btn-default">
                    <i class="fas fa-search"></i>
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
        <!-- /.card-header -->
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                  <tr>
                    <th style="width: auto">Đơn vị tính</th>
                    <th style="width: auto">Chức năng</th>
                  </tr>
                </thead>
                <tbody>
                  @if (count($unit))
                    @foreach ($unit as $item)
                      <tr>
                        <td>{{$item['type']}}</td>
                        <td>
                          <div class="btn-group">
                            <abbr title="Sửa">
                              <a href="{{ route('adminshop.unit.edit', $item['id'])}}" class="mr-1">
                                <button type="button" class="btn btn-default btn-sm mr-2">
                                  <i class="nav-icon fas fa-edit"></i>
                                </button>
                              </a>
                            </abbr>
                            <abbr title="Xóa">
                              <a onclick="return confirm('Bạn có muốn xóa đơn vị tính này không ?')" href="{{ route('adminshop.unit.delete', $item['id'])}}">
                                <button type="button" class="btn btn-default btn-sm">
                                  <i class="fas fa-trash-alt"></i>
                                </button>
                              </a>
                            </abbr>
                          </div>
                        </td>
                      </tr>
                    @endforeach
                  @else
                      <td colspan="2">Không có đơn vị tính</td>
                  @endif
                </tbody>
              </table>
            <hr>
            <div>
              {{$unit->appends(request()->all())->links()}}
            </div>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
@endsection